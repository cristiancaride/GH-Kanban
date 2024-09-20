/// LocalRepositoryViewModel
/// Handles the logic for fetching and displaying local repositories in the UI.
/// Interaction: The view interacts with this ViewModel to get the data for the local repository list.

class LocalRepositoryViewModel {
    
    /// An array of repositories to display in the Local tab.
    var repositories: [Repository] = []
    
    /// Fetches the list of repositories saved locally.
    /// This function currently provides mock data for the first phase of the project.
    /// - Parameter completion: A closure called after fetching the repositories to reload the UI.
    func fetchLocalRepositories(completion: @escaping () -> Void) {
        // Simulated data for the local repositories
        repositories = [
            Repository(name: "Sample Local Repo 1", owner: "User1", repoID: 101),
            Repository(name: "Sample Local Repo 2", owner: "User2", repoID: 102),
            Repository(name: "Sample Local Repo 3", owner: "User3", repoID: 103)
        ]
        completion() // Call the completion to signal that the data is ready to be displayed
    }
}
