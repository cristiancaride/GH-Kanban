import UIKit

/// NextViewController
/// This class represents the Next stage (2/4) in the Kanban board.
/// It will handle displaying the list of next tasks in future phases.

class NextViewController: IssuesViewController {

    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the list of next issues
        issues = [
            Issue(title: "Next Issue 1", info: "Info about Next Issue 1"),
            Issue(title: "Next Issue 2", info: "Info about Next Issue 2")
        ]
        
        // Reload the table view with next stage data
        tableView.reloadData()
    }
}
