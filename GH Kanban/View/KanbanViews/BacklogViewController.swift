import UIKit

/// BacklogViewController
/// This class represents the Backlog stage (1/4) in the Kanban board.
/// It will handle displaying the list of backlog issues in future phases.

class BacklogViewController: UIViewController {

    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color for visual confirmation
        view.backgroundColor = .white
        
        // Add a label for confirmation
        let label = UILabel()
        label.text = "Backlog View"
        label.textAlignment = .center
        label.frame = view.bounds
        view.addSubview(label)
    }
}
