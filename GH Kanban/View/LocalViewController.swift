import UIKit

/// LocalViewController
/// This class manages the Local repositories tab, displaying a list of repositories in a table view.
/// It fetches local repositories from a ViewModel and handles navigation to the Kanban board.
class LocalViewController: UIViewController, UITableViewDelegate {

    /// IBOutlet for the UITableView that displays the list of local repositories.
    @IBOutlet weak var tableView: UITableView!
    
    /// ViewModel to handle fetching and managing the local repositories.
    private let viewModel = LocalRepositoryViewModel()

    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self

        // Fetch the local repositories and populate the table view
        fetchLocalRepositories()
    }

    /// Fetches local repositories from the ViewModel and reloads the table view when done.
    private func fetchLocalRepositories() {
        viewModel.fetchLocalRepositories { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

/// MARK: - UITableViewDataSource
/// This extension handles the data source methods for the table view.
/// It provides the number of rows and the cells to display for each row.
extension LocalViewController: UITableViewDataSource {
    
    /// Returns the number of repositories in the local list.
    /// The number of rows is equal to the count of repositories in the view model.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    /// Returns the UITableViewCell for the given indexPath.
    /// It dequeues a reusable cell of type RepositoryTableViewCell and configures it with the repository data.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use the identifier for the custom cell and cast it to RepositoryTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocalRepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        // Fetch the repository at the current index
        let repo = viewModel.repositories[indexPath.row]
        
        // Assign values to the outlets of the cell
        cell.repoNameLabel.text = repo.name
        cell.repoAuthorLabel.text = repo.owner
        
        return cell
    }
    
    /// Handles the selection of a table view row.
    /// Navigates to the Kanban board by performing a segue and passing the selected repository.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepo = viewModel.repositories[indexPath.row]
        performSegue(withIdentifier: "showKanbanBoard", sender: selectedRepo)
    }
}

/// MARK: - Navigation
/// This method prepares for the segue to the KanbanPageViewController.
/// It passes the selected repository to the KanbanPageViewController to display the Kanban board.
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showKanbanBoard" {
        if let kanbanVC = segue.destination as? KanbanPageViewController,
           let selectedRepo = sender as? Repository {
            // Pass the selected repository to the KanbanPageViewController
            kanbanVC.repository = selectedRepo
        }
    }
}
