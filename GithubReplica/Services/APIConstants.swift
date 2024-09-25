import Foundation

struct APIConstants {
    static func getURL(query: String) -> String {
        return "https://api.github.com/search/users?q=\(query)"
    }
    
    static func getUsersLoginQuery(login: String) -> String {
        return "https://api.github.com/users/\(login)"
    }
    
    static func getUsersReposQuery(login: String) -> String {
        return "https://api.github.com/users/\(login)/repos"
    }
}
