import UIKit

/// DoingViewController
/// This class represents the Doing stage (3/4) in the Kanban board.
/// It will handle displaying the list of ongoing tasks in future phases.

class DoingViewController: IssuesViewController {

    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the list of doing issues
        issues = [
            Issue(title: "Doing Issue 1", info: "Info about Doing Issue 1"),
            Issue(title: "Doing Issue 2", info: "Info about Doing Issue 2")
        ]
        
        // Reload the table view with doing stage data
        tableView.reloadData()
    }
}
