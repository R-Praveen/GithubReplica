import XCTest
import Combine
@testable import GithubReplica

class UserDetailViewModelTests: XCTestCase {
    var viewModel: UserDetailViewModel!
    var mockService: MockGitHubService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockGitHubService()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchUserWithRepositoriesSuccess() {
        // Given
        let mockUser = GitHubUserWithRepos(id: 1, login: "testuser", avatar_url: "https://test.com/avatar.png", name: "Test User", followers: 100, following: 10, bio: "Test bio", repositories: [])
        mockService.userWithReposResult = .success(mockUser)
        
        // When
        viewModel = UserDetailViewModel(login: "testuser", apiService: mockService)
        
        // Then
        let expectation = XCTestExpectation(description: "Fetches user with repositories successfully")
        
        viewModel.$userWithRepos
            .sink { userWithRepos in
                if let user = userWithRepos {
                    XCTAssertEqual(user.login, "testuser")
                    XCTAssertEqual(user.id, 1)
                    XCTAssertEqual(user.name, "Test User")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testFetchUserWithRepositoriesFailure() {
        // Given
        mockService.userWithReposResult = .failure(URLError(.notConnectedToInternet))
        
        // When
        viewModel = UserDetailViewModel(login: "testuser", apiService: mockService)
        
        // Then
        let expectation = XCTestExpectation(description: "Handles failure and userWithRepos remains nil")
        
        viewModel.$userWithRepos
            .sink { userWithRepos in
                XCTAssertNil(userWithRepos) // userWithRepos should remain nil after failure
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}

