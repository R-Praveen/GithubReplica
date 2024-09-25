import SwiftUI
import Combine

class GitHubViewModel: ObservableObject {
    @Published var users = [GitHubUser]() // Keep this to hold the search results
    private var cancellableSet: Set<AnyCancellable> = []

    private let apiService: GithubServiceProtocols
    
    init(apiService: GithubServiceProtocols = GitHubAPIService()) {
        self.apiService = apiService
    }

    // Fetch users based on the search query
    func searchUsers(query: String) {
        apiService.getSearchResults(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellableSet)
    }
}

