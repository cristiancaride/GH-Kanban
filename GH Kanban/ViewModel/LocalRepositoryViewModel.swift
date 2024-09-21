import Foundation

/// LocalRepositoryViewModel
/// Handles the logic for fetching and displaying local repositories in the UI.
/// Interaction: The view interacts with this ViewModel to get the data for the local repository list.
class LocalRepositoryViewModel {
    
    /// Array to hold the locally saved repositories
    var repositories: [Repository] = []
    
    /// This class is responsible for managing the list of repositories that were saved locally.
    /// The `repositories` array holds the list of Repository objects fetched from local storage.
}
