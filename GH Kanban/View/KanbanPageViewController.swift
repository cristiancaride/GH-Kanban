import UIKit

/// KanbanPageViewController
/// Manages the UIPageViewController which navigates between the different Kanban board stages: Backlog, Next, Doing, and Done.
class KanbanPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var repository: Repository?
    
    /// Array that holds the different view controllers for each stage of the Kanban board
    lazy var kanbanStages: [UIViewController] = {
        return [
            BacklogViewController(),  // Backlog (1/4)
            NextViewController(),     // Next (2/4)
            DoingViewController(),    // Doing (3/4)
            DoneViewController()      // Done (4/4)
        ]
    }()
    
    /// NavView to hold the navigation buttons and label
    let navView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        let previousButton = UIButton(type: .system)
        previousButton.setTitle("<", for: .normal)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(previousButton)
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle(">", for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
        let label = UILabel()
        label.text = "1/4"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        // Constraints for previous button
        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            previousButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Constraints for next button
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Constraints for label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source for the page view controller
        self.dataSource = self
        
        // Set the initial view controller (Backlog view)
        if let firstViewController = viewControllerAtIndex(0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Add NavView to the view controller's view
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for NavView to be at the bottom of the view
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navView.heightAnchor.constraint(equalToConstant: 50)
        ])

    }

    /// Data source method for UIPageViewController: Returns the view controller before the current one
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = kanbanStages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return kanbanStages[currentIndex - 1]
    }

    /// Data source method for UIPageViewController: Returns the view controller after the current one
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = kanbanStages.firstIndex(of: viewController), currentIndex < (kanbanStages.count - 1) else {
            return nil
        }
        return kanbanStages[currentIndex + 1]
    }

    /// Method to navigate to a specific page in the Kanban stages
    /// - Parameter index: The index of the page to navigate to (0: Backlog, 1: Next, 2: Doing, 3: Done)
    func goToPage(index: Int) {
        guard index >= 0 && index < kanbanStages.count else { return }
        let targetViewController = kanbanStages[index]
        
        // Determine the navigation direction
        let direction: UIPageViewController.NavigationDirection = index > (viewControllers?.first as? UIViewController)?.view.tag ?? 0 ? .forward : .reverse
        
        // Navigate to the target view controller
        setViewControllers([targetViewController], direction: direction, animated: true, completion: nil)
    }
    
    /// Helper method to get the view controller at a given index
    /// - Parameter index: The index of the desired view controller
    /// - Returns: The view controller at the specified index, or nil if out of bounds
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index < kanbanStages.count {
            return kanbanStages[index]
        }
        return nil
    }
}
