/// GitHubAPIManager
/// Handles the requests to the GitHub API for fetching repositories and issues.
/// Interaction: Used by the ViewModel to request public repositories and issues.

class GitHubAPIManager {
    
    /// Fetches public repositories for a specific GitHub user.
    /// - Parameters:
    ///   - username: The GitHub username to fetch repositories for.
    ///   - completion: A closure that returns an array of Repository objects or an error.
    func fetchRepositories(forUser username: String, completion: @escaping ([Repository]?, Error?) -> Void) {
        // API call to fetch repositories (to be implemented)
    }
    
    /// Fetches issues for a specific repository.
    /// - Parameters:
    ///   - repo: The Repository object to fetch issues for.
    ///   - completion: A closure that returns an array of Issue objects or an error.
    func fetchIssues(forRepository repo: Repository, completion: @escaping ([Issue]?, Error?) -> Void) {
        // API call to fetch issues (to be implemented)
    }
}
