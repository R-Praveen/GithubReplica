import Foundation
import Combine

protocol GithubServiceProtocols {
    func getSearchResults(query: String) -> AnyPublisher<[GitHubUser], Error>
    func fetchUserDetails(login: String) -> AnyPublisher<GitHubUser, Error>
    func fetchUserWithRepositories(login: String) -> AnyPublisher<GitHubUserWithRepos, Error>
}
