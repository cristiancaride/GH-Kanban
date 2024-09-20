import UIKit

class KanbanContainerViewController: UIViewController {

    var kanbanPageVC: KanbanPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // Este método se invoca automáticamente cuando se realiza el segue hacia el KanbanPageViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedKanbanPageViewController" {
            if let pageVC = segue.destination as? KanbanPageViewController {
                // Guardar la referencia al KanbanPageViewController
                self.kanbanPageVC = pageVC
            }
        }
    }
}
