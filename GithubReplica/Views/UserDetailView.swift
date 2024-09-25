import SwiftUI
import Combine
import WebKit

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel

    var body: some View {
        ScrollView {
            if viewModel.userWithRepos == nil {
                Text(Constants.somethingWentWrongText)
                    .padding()
            }
            else {
                VStack(spacing: 20) {
                    // User Profile Section
                    ProfileHeaderView(viewModel: viewModel)

                    // Bio Section
                    if let bio = viewModel.userWithRepos?.bio {
                        Text(bio)
                            .font(.body)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Followers and Following Section
                    FollowersFollowingView(viewModel: viewModel)

                    // User Repositories Section
                    RepositoriesListView(viewModel: viewModel)
                }
                .padding()
            }
        }
        .navigationTitle((viewModel.userWithRepos?.login).emptyIfNil)
        .onAppear {
            viewModel.fetchUserWithRepositories(login: (viewModel.userWithRepos?.login).emptyIfNil)
        }
    }
}

// Subview for Profile Header
struct ProfileHeaderView: View {
    @ObservedObject var viewModel: UserDetailViewModel

    var body: some View {
        ProfileAvatarView(url: (viewModel.userWithRepos?.avatar_url).emptyIfNil)
        Text((viewModel.userWithRepos?.login).emptyIfNil)
            .font(.title)
            .fontWeight(.bold)

        if let name = viewModel.userWithRepos?.name {
            Text(name)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// Subview for Followers and Following counts
struct FollowersFollowingView: View {
    @ObservedObject var viewModel: UserDetailViewModel

    var body: some View {
        HStack {
            VStack {
                Text("\((viewModel.userWithRepos?.followers).zeroIfNil)")
                    .font(.title)
                    .fontWeight(.bold)
                Text(Constants.followers)
                    .font(.caption)
            }

            VStack {
                Text("\((viewModel.userWithRepos?.following).zeroIfNil)")
                    .font(.title)
                    .fontWeight(.bold)
                Text(Constants.following)
                    .font(.caption)
            }
        }
        .padding()
    }
}

// Subview for Repositories List
struct RepositoriesListView: View {
    @ObservedObject var viewModel: UserDetailViewModel

    var body: some View {
        if viewModel.userWithRepos?.repositories.isEmpty ?? true {
            Text(Constants.noRepositoriesAvailableText)
                .padding()
        } else {
            VStack(alignment: .leading) {
                ForEach(viewModel.userWithRepos!.repositories) { repository in
                    NavigationLink(destination: WebView(url: URL(string: repository.html_url.emptyIfNil)!)) {
                        RepositoryRowView(repository: repository)
                    }
                    Divider()
                }
            }
        }
    }
}

// Subview for individual Repository Row
struct RepositoryRowView: View {
    let repository: GitHubRepository // Make sure to define this struct

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(repository.name)
                .font(.headline)

            if let description = repository.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            HStack {
                if let language = repository.language {
                    Text(language)
                        .font(.caption)
                        .foregroundColor(.primary)
                        .padding(.trailing, 10)
                }

                HStack {
                    Image(systemName: Constants.starFillImage)
                    Text("\(repository.stargazers_count)")
                }
                .font(.caption)
                .foregroundColor(.yellow)
            }
            .padding()
        }
    }
}


