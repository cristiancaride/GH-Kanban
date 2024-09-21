import UIKit

/// ExploreViewController
/// This class handles the display of repositories from a given username using a UITableView.
/// It fetches the data from a ViewModel and displays the repositories in a list format.
class ExploreViewController: UIViewController {

    /// IBOutlet for the UITableView that displays the list of repositories.
    @IBOutlet weak var tableView: UITableView!
    
    /// Instance of the RepositoryViewModel that handles the logic and data for this controller.
    private let viewModel = RepositoryViewModel()
    
    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the data source for the table view
        tableView.dataSource = self
        
        // Fetch repositories for the given username
        fetchRepositories()
    }

    /// Fetches repositories for the given username using the view model.
    /// Once the repositories are fetched, the table view is reloaded to display the data.
    private func fetchRepositories() {
        viewModel.fetchRepositories(forUsername: "inqbarna") { [weak self] in
            DispatchQueue.main.async {
                // Reload the table view with the fetched data
                self?.tableView.reloadData()
                // Print the repositories to check if data is being fetched correctly
                print(self?.viewModel.repositories ?? "No repositories fetched")
            }
        }
    }
}

/// MARK: - UITableViewDataSource
/// This extension handles the data source methods for the table view.
/// It provides the number of rows and the cells to display for each row.
extension ExploreViewController: UITableViewDataSource {
    
    /// Returns the number of rows in the table view.
    /// The number of rows is equal to the count of repositories in the view model.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    /// Returns the UITableViewCell for the given indexPath.
    /// It dequeues a reusable cell of type RepositoryTableViewCell and configures it with the repository data.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        // Fetch the repository at the current index
        let repo = viewModel.repositories[indexPath.row]
        
        // Assign values to the outlets of the cell
        cell.repoNameLabel.text = repo.name
        cell.repoAuthorLabel.text = repo.owner.login  // Using the 'login' field from owner
        cell.addButtonImageView.setImage(UIImage(systemName: "plus"), for: .normal)
        
        // Assign a target to the "plus" button to save the repository when pressed
        cell.addButtonImageView.addTarget(self, action: #selector(saveRepo(_:)), for: .touchUpInside)
        cell.addButtonImageView.tag = indexPath.row  // Assign the row index to the button's tag for reference

        return cell
    }

    /// Save the repository to local storage when the "plus" button is pressed.
    /// - Parameter sender: The button that was pressed (used to identify the selected repository).
    @objc private func saveRepo(_ sender: UIButton) {
        let repo = viewModel.repositories[sender.tag]
        
        // Save the repository locally using PersistenceManager
        PersistenceManager().saveRepository(repo)
        
        // Send a notification that a repository has been saved
        NotificationCenter.default.post(name: NSNotification.Name("repositorySaved"), object: nil)

        // Print confirmation for debugging purposes
        print("\(repo.name) saved to local.")
    }
}
