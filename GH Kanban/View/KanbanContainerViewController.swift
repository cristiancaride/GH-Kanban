import UIKit

/// KanbanContainerViewController
/// This class manages the container that holds the `KanbanPageViewController`.
/// It acts as a parent view controller for embedding the page view controller.
class KanbanContainerViewController: UIViewController {

    /// Reference to the `KanbanPageViewController` that manages the Kanban stages.
    var kanbanPageVC: KanbanPageViewController?
    
    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup can be done here in future phases
    }

    /// This method is automatically invoked when a segue is performed to the `KanbanPageViewController`.
    /// - Parameters:
    ///   - segue: The segue object containing information about the view controllers involved.
    ///   - sender: The object that initiated the segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedKanbanPageViewController" {
            if let pageVC = segue.destination as? KanbanPageViewController {
                // Save the reference to the KanbanPageViewController
                self.kanbanPageVC = pageVC
            }
        }
    }
}
