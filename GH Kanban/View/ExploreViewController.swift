import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = RepositoryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asign dataSource
        tableView.dataSource = self
        
        fetchRepositories()
    }


    private func fetchRepositories() {
        viewModel.fetchRepositories(forUsername: "inqbarna") { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let repo = viewModel.repositories[indexPath.row]
        
        // Assign values to the outlets
        cell.repoNameLabel.text = repo.name
        cell.repoAuthorLabel.text = repo.owner
        cell.addButtonImageView.setImage(UIImage(systemName: "plus"), for: .normal)
        
        return cell
    }
}
