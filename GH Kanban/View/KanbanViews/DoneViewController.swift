import UIKit

/// DoneViewController
/// This class represents the Done stage (4/4) in the Kanban board.
/// It will handle displaying the list of completed tasks in future phases.

class DoneViewController: IssuesViewController {

    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the list of done issues
        issues = [
            Issue(title: "Done Issue 1", info: "Info about Done Issue 1"),
            Issue(title: "Done Issue 2", info: "Info about Done Issue 2")
        ]
        
        // Reload the table view with done stage data
        tableView.reloadData()
    }
}
