import Foundation

/// GithubAPIManager
/// This class handles communication with the GitHub API to fetch repositories and issues for a given repository or username.
class GithubAPIManager {

    /// Shared singleton instance of `GithubAPIManager`
    static let shared = GithubAPIManager()
    
    /// Base URL for the GitHub API
    private let baseURL = "https://api.github.com"
    
    /// Fetches repositories for a given GitHub username.
    /// - Parameters:
    ///   - username: The GitHub username for which to fetch repositories.
    ///   - completion: Completion handler that returns an array of `Repository` objects.
    func getRepositories(forUsername username: String, completion: @escaping ([Repository]) -> Void) {
        let urlString = "\(baseURL)/users/\(username)/repos"  // Construct the API endpoint URL
        
        // Create URL from the string
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])  // Return an empty array if the URL is invalid
            return
        }
        
        // Create a data task to fetch repositories from the API
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check for errors in the request
            guard let data = data, error == nil else {
                print("Error fetching repositories: \(String(describing: error))")
                completion([])  // Return an empty array if there's an error
                return
            }
            
            do {
                // Decode the fetched JSON data into an array of `Repository` objects
                let repositories = try JSONDecoder().decode([Repository].self, from: data)
                completion(repositories)  // Pass the array to the completion handler
            } catch {
                print("Error decoding repositories: \(error)")
                completion([])  // Return an empty array if decoding fails
            }
        }
        
        task.resume()  // Start the data task
    }
    
    /// Fetches issues for a given repository from GitHub.
    /// - Parameters:
    ///   - repoName: The name of the repository.
    ///   - owner: The owner of the repository.
    ///   - completion: Completion handler that returns an array of Issue objects.
    func fetchIssues(forRepo repoName: String, owner: String, completion: @escaping ([Issue]) -> Void) {
        let urlString = "https://api.github.com/repos/\(owner)/\(repoName)/issues"  // Construct the API endpoint for issues
        
        // Validate the URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])  // Return an empty array if the URL is invalid
            return
        }

        // Create a data task to fetch issues from the API
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors in the request
            if let error = error {
                print("Error fetching issues: \(error.localizedDescription)")
                completion([])  // Return an empty array if there's an error
                return
            }

            // Ensure data is returned
            guard let data = data else {
                print("No data returned")
                completion([])  // Return an empty array if no data is returned
                return
            }

            do {
                // Decode the fetched JSON data into an array of `Issue` objects
                let issues = try JSONDecoder().decode([Issue].self, from: data)
                completion(issues)  // Pass the array of issues to the completion handler
            } catch {
                print("Error decoding issues: \(error.localizedDescription)")
                completion([])  // Return an empty array if decoding fails
            }
        }
        task.resume()  // Start the data task
    }
}
