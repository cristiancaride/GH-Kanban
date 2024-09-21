import Foundation

/// PersistenceManager
/// This class manages saving and loading repositories and issues to and from local storage using UserDefaults.
class PersistenceManager {

    /// Key used to store the saved repositories in UserDefaults
    private let savedReposKey = "savedReposKey"
    
    /// Key used to store the saved issues in UserDefaults
    private let savedIssuesKey = "savedIssuesKey"

    // MARK: - Repository Persistence

    /// Saves a repository to local storage.
    /// - Parameter repository: The repository to save.
    func saveRepository(_ repository: Repository) {
        // Load existing repositories from local storage
        var savedRepos = loadSavedRepositories()
        
        // Append the new repository to the list
        savedRepos.append(repository)
        
        // Encode the updated list of repositories and save to UserDefaults
        if let encodedData = try? JSONEncoder().encode(savedRepos) {
            UserDefaults.standard.set(encodedData, forKey: savedReposKey)
        }
    }
    
    /// Loads saved repositories from local storage.
    /// - Returns: An array of saved repositories.
    func loadSavedRepositories() -> [Repository] {
        // Retrieve the stored data from UserDefaults and decode it into an array of Repository objects
        guard let data = UserDefaults.standard.data(forKey: savedReposKey),
              let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
            return []  // Return an empty array if no data is found
        }
        return repositories
    }
    
    /// Removes a repository from local storage.
    /// - Parameter repository: The repository to remove.
    func removeRepository(_ repository: Repository) {
        // Load the saved repositories
        var savedRepos = loadSavedRepositories()
        
        // Find the index of the repository to remove by comparing IDs
        if let index = savedRepos.firstIndex(where: { $0.id == repository.id }) {
            savedRepos.remove(at: index)  // Remove the repository from the list
            
            // Save the updated list of repositories
            if let encodedData = try? JSONEncoder().encode(savedRepos) {
                UserDefaults.standard.set(encodedData, forKey: savedReposKey)
            }
        }
    }

    // MARK: - Issue Persistence

    /// Saves the updated list of issues to UserDefaults.
    /// - Parameter issues: The list of issues to save.
    func saveIssues(_ issues: [Issue]) {
        // Encode the issues and save to UserDefaults
        if let encodedData = try? JSONEncoder().encode(issues) {
            UserDefaults.standard.set(encodedData, forKey: savedIssuesKey)
        }
    }
    
    /// Loads the saved list of issues from UserDefaults.
    /// - Returns: The list of saved issues, or an empty array if none are found.
    func loadIssues() -> [Issue] {
        // Retrieve and decode the stored issues
        guard let data = UserDefaults.standard.data(forKey: savedIssuesKey),
              let issues = try? JSONDecoder().decode([Issue].self, from: data) else {
            return []  // Return an empty array if no issues are found
        }
        return issues
    }

    /// Updates a specific issue in the saved list and persists the change.
    /// - Parameter updatedIssue: The issue to be updated.
    func updateIssue(_ updatedIssue: Issue) {
        // Load existing issues from local storage
        var issues = loadIssues()
        
        // Find the index of the issue to update by matching IDs
        if let index = issues.firstIndex(where: { $0.id == updatedIssue.id }) {
            // Update the issue at the found index
            issues[index] = updatedIssue
            
            // Save the updated list of issues
            saveIssues(issues)
            
            // Debugging print statement to confirm the update
            print("Issue \(updatedIssue.id) updated with state: \(updatedIssue.state)")
        }
    }
}
