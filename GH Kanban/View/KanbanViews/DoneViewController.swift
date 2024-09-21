import UIKit

/// DoneViewController
/// This class represents the Done phase (4/4) in the Kanban board.
/// It manages the issues that have been completed.
class DoneViewController: IssuesViewController {
    
    var repository: Repository?  // The selected repository to load issues from
    
    /// This method is called every time the view appears, ensuring the issues are reloaded.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadIssues()  // Reload issues each time the view appears
    }

    /// Loads the issues specific to the Done stage.
    /// It retrieves the issues from PersistenceManager and filters them by the "done" state.
    override func loadIssues() {
        // Load saved issues from PersistenceManager
        let savedIssues = PersistenceManager().loadIssues()
        
        // Filter the issues to show only those in the "done" phase
        self.issues = savedIssues.filter { $0.state == "done" }
        tableView.reloadData()
    }
    
    /// Adds an issue to the Done phase.
    /// - Parameter issue: The issue to be added to the Done phase.
    func addIssue(_ issue: Issue) {
        issues.append(issue)
        tableView.reloadData()  // Refresh the table view to show the new issue
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
                       onMoveToNext: {},  // No next phase for Done issues
                       onMoveToPrevious: { [weak self] in
            self?.moveIssueToPreviousBoard(issue: issue, indexPath: indexPath)  // Move issue back to Doing
        })

        return cell
    }

    // MARK: - Movement Methods

    /// Moves an issue back to the previous board (Doing phase) and removes it from the current board (Done phase).
    /// - Parameters:
    ///   - issue: The issue to be moved.
    ///   - indexPath: The index of the issue in the table view.
    internal override func moveIssueToPreviousBoard(issue: Issue, indexPath: IndexPath) {
        // 1. Remove the issue from Done
        issues.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // 2. Update the issue state to "doing"
        var updatedIssue = issue
        updatedIssue.state = "doing"
        
        // 3. Save the updated issue state in PersistenceManager
        PersistenceManager().updateIssue(updatedIssue)

        // 4. Move the issue back to DoingViewController
        if let doingVC = parent?.children.first(where: { $0 is DoingViewController }) as? DoingViewController {
            doingVC.addIssue(updatedIssue)
        }
    }
}
