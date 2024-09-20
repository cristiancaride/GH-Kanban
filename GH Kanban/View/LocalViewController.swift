import UIKit

class LocalViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // Use a specific ViewModel for the Local tab
    private let viewModel = LocalRepositoryViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign dataSource
        tableView.dataSource = self
        tableView.delegate = self

        // Fetch local repositories (mock data temporarily)
        fetchLocalRepositories()
    }

    // Fetch repositories from the ViewModel and reload the table view when done
    private func fetchLocalRepositories() {
        viewModel.fetchLocalRepositories { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension LocalViewController: UITableViewDataSource {
    
    // Return the number of repositories in the local list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    // Configure each cell with repository data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Use the identifier for the custom cell and cast it to RepositoryTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocalRepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let repo = viewModel.repositories[indexPath.row]
        
        // Set the cell's labels with repository information
        cell.repoNameLabel.text = repo.name
        cell.repoAuthorLabel.text = repo.owner
        
        return cell
    }
    
    // Navigate to Kanban Board Navigation View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRepo = viewModel.repositories[indexPath.row]
        performSegue(withIdentifier: "showKanbanBoard", sender: selectedRepo)
    }
}

// Prepare for the segue
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showKanbanBoard" {
        if let kanbanVC = segue.destination as? KanbanPageViewController,
           let selectedRepo = sender as? Repository {
            // Pass the selected repository to the KanbanPageViewController
            kanbanVC.repository = selectedRepo
        }
    }
}
