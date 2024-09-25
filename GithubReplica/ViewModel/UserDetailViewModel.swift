import Foundation
import Combine

class UserDetailViewModel: ObservableObject {
    @Published var userWithRepos: GitHubUserWithRepos?

    private var cancellableSet: Set<AnyCancellable> = []
    private let apiService: GithubServiceProtocols

    init(login: String, apiService: GithubServiceProtocols) {
        self.apiService = apiService
        fetchUserWithRepositories(login: login)
    }

    func fetchUserWithRepositories(login: String) {
        apiService.fetchUserWithRepositories(login: login)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching user and repositories: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] userWithRepos in
                self?.userWithRepos = userWithRepos
            })
            .store(in: &cancellableSet)
    }
}
