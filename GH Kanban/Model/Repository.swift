import Foundation

/// Repository
/// This struct represents a GitHub repository and conforms to Codable for easy encoding/decoding.
/// It is also Equatable, which allows comparing two repositories based on their ID.
struct Repository: Codable, Equatable {
    let name: String           // The name of the repository
    let owner: Owner           // The owner (user or organization) of the repository
    let description: String?   // A brief description of the repository, optional
    let id: Int                // The unique identifier for the repository
    
    /// Equatable implementation to compare two repositories by their ID.
    /// - Parameters:
    ///   - lhs: The first repository to compare.
    ///   - rhs: The second repository to compare.
    /// - Returns: A Boolean value indicating whether the two repositories are equal based on their ID.
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
}

/// Owner
/// This struct represents the owner of a GitHub repository and conforms to Codable for easy encoding/decoding.
/// The owner could be either a user or an organization.
struct Owner: Codable, Equatable {
    let login: String  // The login name of the owner (username or organization name)
}
