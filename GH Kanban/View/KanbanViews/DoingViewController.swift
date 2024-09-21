import UIKit

/// DoingViewController
/// This class represents the Doing phase (3/4) in the Kanban board.
/// It manages displaying and moving issues within the Doing stage.
class DoingViewController: IssuesViewController {
    
    var repository: Repository?  // The selected repository to load issues from
    
    /// This method is called every time the view appears, ensuring that issues are reloaded.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadIssues()  // Reload issues each time the view appears
    }
    
    /// Loads the issues specific to the Doing stage.
    /// It retrieves the issues from PersistenceManager and filters them by the "doing" state.
    override func loadIssues() {
        // Load saved issues from PersistenceManager
        let savedIssues = PersistenceManager().loadIssues()
        
        // Filter the issues to show only those in the "doing" phase
        self.issues = savedIssues.filter { $0.state == "doing" }
        tableView.reloadData()
    }
    
    /// Adds an issue to the Doing phase.
    /// - Parameter issue: The issue to be added to the Doing phase.
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
                       onMoveToNext: { [weak self] in
            self?.moveIssueToNextBoard(issue: issue, indexPath: indexPath)  // Move issue to Done phase
        },
                       onMoveToPrevious: { [weak self] in
            self?.moveIssueToPreviousBoard(issue: issue, indexPath: indexPath)  // Move issue back to Next
        })

        return cell
    }

    // MARK: - Movement Methods

    /// Moves an issue to the next board (Done phase) and removes it from the current board (Doing phase).
    /// - Parameters:
    ///   - issue: The issue to be moved.
    ///   - indexPath: The index of the issue in the table view.
    internal override func moveIssueToNextBoard(issue: Issue, indexPath: IndexPath) {
        // 1. Remove the issue from the Doing phase
        issues.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // 2. Update the issue state to "done"
        var updatedIssue = issue
        updatedIssue.state = "done"
        
        // 3. Save the updated issue state in PersistenceManager
        PersistenceManager().updateIssue(updatedIssue)

        // 4. Move the issue to the DoneViewController
        if let doneVC = parent?.children.first(where: { $0 is DoneViewController }) as? DoneViewController {
            doneVC.addIssue(updatedIssue)
        }
    }
    
    /// Moves an issue back to the previous board (Next phase) and removes it from the current board (Doing phase).
    /// - Parameters:
    ///   - issue: The issue to be moved.
    ///   - indexPath: The index of the issue in the table view.
    internal override func moveIssueToPreviousBoard(issue: Issue, indexPath: IndexPath) {
        // 1. Remove the issue from the Doing phase
        issues.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // 2. Update the issue state to "next"
        var updatedIssue = issue
        updatedIssue.state = "next"
        
        // 3. Save the updated issue state in PersistenceManager
        PersistenceManager().updateIssue(updatedIssue)

        // 4. Move the issue back to the NextViewController
        if let nextVC = parent?.children.first(where: { $0 is NextViewController }) as? NextViewController {
            nextVC.addIssue(updatedIssue)
        }
    }
}
