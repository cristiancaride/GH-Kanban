import UIKit

/// LocalViewController
/// This class handles displaying the repositories saved locally.
class LocalViewController: UIViewController {

    /// IBOutlet for the UITableView that displays the list of saved repositories.
    @IBOutlet weak var tableView: UITableView!
    
    /// Instance of the ViewModel that manages the data for the Local tab.
    private let viewModel = LocalRepositoryViewModel()
    
    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the data source and delegate for the table view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Load saved repositories from PersistenceManager.
        loadSavedRepositories()
        
        // Add an observer to listen for the repository saved notification.
        NotificationCenter.default.addObserver(self, selector: #selector(repositorySavedNotification), name: NSNotification.Name("repositorySaved"), object: nil)
    }

    /// Method triggered when a repository is saved.
    @objc private func repositorySavedNotification() {
        // Reload the saved repositories from local storage.
        loadSavedRepositories()
    }

    /// Loads the saved repositories from PersistenceManager and updates the table view.
    private func loadSavedRepositories() {
        // Retrieve saved repositories from the PersistenceManager.
        let savedRepos = PersistenceManager().loadSavedRepositories()
        
        // Update the view model's repository list.
        viewModel.repositories = savedRepos
        
        // Reload the table view to display the saved repositories.
        tableView.reloadData()
    }
    
    /// Prepares for the segue to KanbanPageViewController.
    /// This method passes the selected repository to the KanbanPageViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showKanbanBoard" {
            if let kanbanVC = segue.destination as? KanbanPageViewController,
               let selectedRepo = sender as? Repository {
                // Pass the selected repository to KanbanPageViewController.
                kanbanVC.repository = selectedRepo
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension LocalViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the table view.
    /// The number of rows is equal to the count of saved repositories in the view model.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    /// Returns the UITableViewCell for the given indexPath.
    /// It dequeues a reusable cell of type RepositoryTableViewCell and configures it with the repository data.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocalRepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        // Fetch the repository at the current index.
        let repo = viewModel.repositories[indexPath.row]
        
        // Set the cell's labels with the repository's name and owner information.
        cell.repoNameLabel.text = repo.name
        cell.repoAuthorLabel.text = repo.owner.login
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocalViewController: UITableViewDelegate {
    
    /// This method detects when a row is selected.
    /// It performs the segue to the KanbanPageViewController and passes the selected repository.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch the repository that was selected.
        let selectedRepo = viewModel.repositories[indexPath.row]
        
        // Perform the segue to show the Kanban board for the selected repository.
        performSegue(withIdentifier: "showKanbanBoard", sender: selectedRepo)
    }
}
