import UIKit

/// BacklogViewController
/// This class represents the Backlog stage (1/4) in the Kanban board.
/// It handles loading and displaying issues that are in the "open" state for the Backlog phase.
class BacklogViewController: IssuesViewController {
    
    var repository: Repository?  // The selected repository to load issues from
    
    /// This method is called every time the view appears, ensuring the issues are reloaded.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadIssues()  // Reload issues each time the view appears
    }
    
    /// Loads the issues specific to the Backlog stage.
    /// If there are no saved issues, it fetches issues from the GitHub API.
    override func loadIssues() {
        // Load saved issues from local storage
        let savedIssues = PersistenceManager().loadIssues()
        self.issues = savedIssues.filter { $0.state == "open" }
        tableView.reloadData()

        // If there are no saved issues, fetch them from the API
        if issues.isEmpty && savedIssues.isEmpty {
            guard let repo = repository else { return }

            // Fetch issues from the GitHub API for the selected repository
            GithubAPIManager.shared.fetchIssues(forRepo: repo.name, owner: repo.owner.login) { [weak self] (fetchedIssues: [Issue]) in
                DispatchQueue.main.async {
                    // Save the fetched issues in PersistenceManager
                    PersistenceManager().saveIssues(fetchedIssues)
                    
                    // Filter issues to show only those in the "open" state
                    self?.issues = fetchedIssues.filter { $0.state == "open" }
                    self?.tableView.reloadData()  // Reload the table with the fetched issues
                }
            }
        } else {
            tableView.reloadData()
        }
    }
    
    /// Adds an issue to the Backlog phase.
    /// - Parameter issue: The issue to be added to the Backlog phase.
    func addIssue(_ issue: Issue) {
        issues.append(issue)
        tableView.reloadData()
    }

    // MARK: - TableView DataSource & Delegate

    /// Populates each cell in the table view with issue data and assigns callbacks for navigation buttons.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell", for: indexPath) as? IssueTableViewCell else {
            return UITableViewCell()
        }

        let issue = issues[indexPath.row]
        
        // Configure the cell with issue data and navigation callbacks
        cell.configure(with: issue,
                       onMoveToNext: { [weak self] in
            self?.moveIssueToNextBoard(issue: issue, indexPath: indexPath)  // Callback to move issue to the next board
        },
                       onMoveToPrevious: {})  // No previous phase for Backlog

        return cell
    }

    // MARK: - Movement Methods
    
    /// Moves an issue to the Next board (Next phase) and removes it from the Backlog.
    /// - Parameters:
    ///   - issue: The issue to be moved.
    ///   - indexPath: The index of the issue in the table view.
    internal override func moveIssueToNextBoard(issue: Issue, indexPath: IndexPath) {
        // Remove the issue from Backlog
        issues.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // Update the issue state to reflect the move to the Next phase
        var updatedIssue = issue
        updatedIssue.state = "next"
        
        // Save the updated issue state in PersistenceManager
        PersistenceManager().updateIssue(updatedIssue)

        // Move the issue to the NextViewController
        if let nextVC = parent?.children.first(where: { $0 is NextViewController }) as? NextViewController {
            nextVC.addIssue(updatedIssue)
        }
    }
}
