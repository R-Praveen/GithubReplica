import SwiftUI
import Combine

// SwiftUI View
struct SearchView: View {
    @StateObject private var viewModel = GitHubViewModel(apiService: GitHubAPIService())
    @State private var searchQuery = ""

    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                TextField(Constants.searchGithubUsersText, text: $searchQuery, onCommit: {
                    viewModel.searchUsers(query: searchQuery)
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

                // List of GitHub users
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(login: user.login.emptyIfNil, apiService: GitHubAPIService()))) {
                        HStack {
                            ListAvatarView(url: user.avatar_url.emptyIfNil)
                            Text(user.login.emptyIfNil)
                        }
                    }
                }
            }
            .navigationTitle(Constants.searchPagenavBarTitle)
        }
    }
}

// Preview
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


