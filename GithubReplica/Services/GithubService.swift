import Foundation
import Combine

class GitHubAPIService: GithubServiceProtocols {
    public let session: URLSession
    
    // Injecting the session, defaulting to URLSession.shared
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Search GitHub users using the API
    func getSearchResults(query: String) -> AnyPublisher<[GitHubUser], Error> {
        
        guard let url = URL(string: APIConstants.getURL(query: query)) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map { $0.data}
            .decode(type: GitHubSearchResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .eraseToAnyPublisher()
    }
    
    // Fetch detailed user information using GitHub's User API
    func fetchUserDetails(login: String) -> AnyPublisher<GitHubUser, Error> {
        guard let url = URL(string: APIConstants.getUsersLoginQuery(login: login)) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map { $0.data}
            .decode(type: GitHubUser.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchUserWithRepositories(login: String) -> AnyPublisher<GitHubUserWithRepos, Error> {
        guard let usersURL = URL(string: APIConstants.getUsersLoginQuery(login: login)),
              let reposURL = URL(string: APIConstants.getUsersReposQuery(login: login)) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        // Publisher to fetch user details
        let userPublisher = URLSession.shared.dataTaskPublisher(for: usersURL)
            .map(\.data)
            .decode(type: GitHubUser.self, decoder: JSONDecoder())
        
        // Publisher to fetch repositories
        let reposPublisher = URLSession.shared.dataTaskPublisher(for: reposURL)
            .map(\.data)
            .decode(type: [GitHubRepository].self, decoder: JSONDecoder())
            .map { repositories in
                repositories.filter { !$0.fork }  // Filter non-forked repos
            }
        
        // Combine the two publishers
        return Publishers.Zip(userPublisher, reposPublisher)
            .map { (user, repositories) in
                GitHubUserWithRepos(
                    id: user.id.zeroIfNil,
                    login: user.login.emptyIfNil,
                    avatar_url: user.avatar_url.emptyIfNil,
                    name: user.name,
                    followers: user.followers,
                    following: user.following,
                    bio: user.bio,
                    repositories: repositories
                )
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
