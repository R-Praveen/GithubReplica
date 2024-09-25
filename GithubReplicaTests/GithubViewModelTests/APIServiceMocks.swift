import Combine
import XCTest
@testable import GithubReplica

class MockGitHubService: GithubServiceProtocols {
    var searchResult: Result<[GitHubUser], Error>?
    var userDetailsResult: Result<GitHubUser, Error>?
    var userWithReposResult: Result<GitHubUserWithRepos, Error>?

    func getSearchResults(query: String) -> AnyPublisher<[GitHubUser], Error> {
        if let result = searchResult {
            return result.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }

    func fetchUserDetails(login: String) -> AnyPublisher<GitHubUser, Error> {
        if let result = userDetailsResult {
            return result.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }

    func fetchUserWithRepositories(login: String) -> AnyPublisher<GitHubUserWithRepos, Error> {
            if let result = userWithReposResult {
                return result.publisher.eraseToAnyPublisher()
            } else {
                return Fail(error: URLError(.badServerResponse))
                    .eraseToAnyPublisher()
            }
        }
}


