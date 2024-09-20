/// RepositoryViewModel
/// Handles the  logic for fetching and displaying repositories in the UI.
/// Interaction: The view interacts with this ViewModel to get the data for the repository list.

class RepositoryViewModel {
    private let apiManager = GitHubAPIManager()
    
    /// An array of repositories to display in the UI.
    var repositories: [Repository] = []
    
    /// Fetches repositories for a given GitHub username.
    /// - Parameter username: The GitHub username to fetch repositories for.
    func fetchRepositories(forUsername username: String, completion: @escaping () -> Void) {
        // Added some sample repositories
        repositories = [
            Repository(name: "GH Kanban", owner: "Cristian Caride", repoID: 1),
            Repository(name: "Sample Project", owner: "Inqbarna", repoID: 2),
            Repository(name: "Test Repo", owner: "Cristian Caride", repoID: 3)
        ]
        completion() // Call the completion to reload the table view

        apiManager.fetchRepositories(forUser: username) { [weak self] (repos, error) in
            if let repos = repos {
                self?.repositories = repos
            }
            completion()
        }
    }
}
