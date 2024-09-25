import Foundation

struct GitHubUserWithRepos: Identifiable {
    let id: Int
    let login: String
    let avatar_url: String
    var name: String?
    var followers: Int?
    var following: Int?
    var bio: String?
    var repositories: [GitHubRepository]  // Repositories included
}

struct GitHubRepository: Identifiable, Codable {
    let id: Int
    let name: String
    let language: String?
    let stargazers_count: Int
    let description: String?
    let html_url: String?
    let fork: Bool  // Indicates if the repository is a fork

    // Add any other properties that you might need
}

// Response model for GitHub search
struct GitHubSearchResponse: Decodable, Encodable {
    let items: [GitHubUser]
}

// Model to store GitHub user information
struct GitHubUser: Identifiable, Decodable, Encodable {
    let id: Int?
    let login: String?
    let avatar_url: String?
    var name: String?
    var followers: Int?
    var following: Int?
    var bio: String?
}
