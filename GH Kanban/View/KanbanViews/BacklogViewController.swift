import UIKit

/// BacklogViewController
/// This class represents the Backlog stage (1/4) in the Kanban board.
/// It will handle displaying the list of backlog issues in future phases.

class BacklogViewController: IssuesViewController {

    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the list of backlog issues
        issues = [
            Issue(title: "Backlog Issue 1", info: "Info about Backlog Issue 1"),
            Issue(title: "Backlog Issue 2", info: "Info about Backlog Issue 2")
        ]
        
        // Reload the table view with backlog data
        tableView.reloadData()
    }
}
