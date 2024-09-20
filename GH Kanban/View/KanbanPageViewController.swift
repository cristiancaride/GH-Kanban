import UIKit

/// KanbanPageViewController
/// Manages the UIPageViewController which navigates between the different Kanban board stages: Backlog, Next, Doing, and Done.
class KanbanPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    /// The repository associated with the Kanban board, passed from the previous view controller.
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
    
    /// Custom navigation view that holds the navigation buttons and label
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
        label.text = "Backlog"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        // Constraints for buttons and label
        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            previousButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()

    /// The current index of the Kanban stages, used to track and update the navigation
    var currentIndex = 0 {
        didSet {
            updateNavLabel()
        }
    }
    
    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source and delegate for the page view controller
        self.dataSource = self
        self.delegate = self
        
        // Set the initial view controller (Backlog view)
        if let firstViewController = viewControllerAtIndex(0) {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Add NavView to the view
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for the NavView
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add target actions for the navigation buttons
        if let previousButton = navView.subviews.first(where: { $0 is UIButton && ($0 as! UIButton).title(for: .normal) == "<" }) as? UIButton {
            previousButton.addTarget(self, action: #selector(goToPreviousPage), for: .touchUpInside)
        }
        
        if let nextButton = navView.subviews.first(where: { $0 is UIButton && ($0 as! UIButton).title(for: .normal) == ">" }) as? UIButton {
            nextButton.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        }
    }
    
    // MARK: - Navigation Methods

    /// Navigates to the previous page (Kanban stage) when the previous button is tapped.
    @objc private func goToPreviousPage() {
        if currentIndex > 0 {
            currentIndex -= 1
            let previousViewController = kanbanStages[currentIndex]
            setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
            updateNavLabel() // Update the label after changing pages
        }
    }

    /// Navigates to the next page (Kanban stage) when the next button is tapped.
    @objc private func goToNextPage() {
        if currentIndex < kanbanStages.count - 1 {
            currentIndex += 1
            let nextViewController = kanbanStages[currentIndex]
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
            updateNavLabel() // Update the label after changing pages
        }
    }

    /// Updates the label in the NavView to reflect the current Kanban stage name.
    private func updateNavLabel() {
        // Array with the names of the Kanban stages
        let stageNames = ["Backlog", "Next", "Doing", "Done"]
        
        // Update the label with the current stage name
        if let label = navView.subviews.first(where: { $0 is UILabel }) as? UILabel {
            label.text = "\(stageNames[currentIndex])"
        }
    }


    // MARK: - UIPageViewControllerDataSource
    
    /// Returns the view controller before the current one in the page view controller.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = kanbanStages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return kanbanStages[currentIndex - 1]
    }
    
    /// Returns the view controller after the current one in the page view controller.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = kanbanStages.firstIndex(of: viewController), currentIndex < kanbanStages.count - 1 else {
            return nil
        }
        return kanbanStages[currentIndex + 1]
    }

    /// Helper method to get the view controller at a given index.
    /// - Parameter index: The index of the desired view controller.
    /// - Returns: The view controller at the specified index, or nil if out of bounds.
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if index >= 0 && index < kanbanStages.count {
            return kanbanStages[index]
        }
        return nil
    }
}
