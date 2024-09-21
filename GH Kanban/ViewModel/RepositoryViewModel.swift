import Foundation

/// RepositoryViewModel
/// This class manages the fetching and storing of repositories.
/// It fetches repositories from GitHub and saves them locally.
class RepositoryViewModel {
    
    /// Array to hold the fetched repositories
    var repositories: [Repository] = []
    
    /// Fetches repositories for a given username and stores them locally.
    /// - Parameters:
    ///   - username: The username for which to fetch the repositories.
    ///   - completion: Completion handler to be called after repositories are fetched.
    func fetchRepositories(forUsername username: String, completion: @escaping () -> Void) {
        // Call the API manager to fetch repositories for the given username
        GithubAPIManager.shared.getRepositories(forUsername: username) { [weak self] repos in
            // Store the fetched repositories in the local array
            self?.repositories = repos
            
            // Save the repositories to local storage (UserDefaults)
            self?.saveRepositories(repos)
            
            // Call the completion handler to notify that fetching is complete
            completion()
        }
    }
    
    /// Saves the fetched repositories to UserDefaults as encoded JSON.
    /// - Parameter repositories: The array of repositories to save.
    private func saveRepositories(_ repositories: [Repository]) {
        let encoder = JSONEncoder()
        
        // Encode the repositories array to JSON and save it to UserDefaults
        if let encodedData = try? encoder.encode(repositories) {
            UserDefaults.standard.set(encodedData, forKey: "savedRepositories")
        }
    }
}
