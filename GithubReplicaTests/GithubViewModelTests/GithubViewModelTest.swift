import XCTest
import Combine
@testable import GithubReplica

class GitHubViewModelTests: XCTestCase {

    var viewModel: GitHubViewModel!
    var mockService: MockGitHubService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockGitHubService()
        viewModel = GitHubViewModel(apiService: mockService)
        cancellables = []
    }

    override func tearDown() {
        cancellables = []
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // Test for successful search
    func testSearchUsersSuccess() {
        // Given
        let mockUsers = [
            GitHubUser(id: 1, login: "user1", avatar_url: nil, name: nil, followers: nil, following: nil, bio: nil),
            GitHubUser(id: 2, login: "user2", avatar_url: nil, name: nil, followers: nil, following: nil, bio: nil)
        ]
        mockService.searchResult = .success(mockUsers)
        
        // When
        let expectation = XCTestExpectation(description: "Search completes successfully")
        viewModel.searchUsers(query: "test")
        
        // Then
        viewModel.$users
            .dropFirst() // Ignore the initial value
            .sink { users in
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].login, "user1")
                XCTAssertEqual(users[1].login, "user2")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    // Test for empty search result
    func testSearchUsersEmptyResult() {
        // Given
        mockService.searchResult = .success([]) // No users returned
        
        // When
        let expectation = XCTestExpectation(description: "Search returns empty result")
        viewModel.searchUsers(query: "test")
        
        // Then
        viewModel.$users
            .dropFirst()
            .sink { users in
                XCTAssertTrue(users.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }
}

