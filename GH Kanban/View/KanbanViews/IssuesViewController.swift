import UIKit

/// IssuesViewController
/// This class handles displaying a list of issues in a table view.
/// It will be subclassed by specific view controllers like BacklogViewController, NextViewController, etc.
class IssuesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    /// Table view to display the list of issues
    let tableView = UITableView()

    /// Array of issues that will populate the table
    var issues: [Issue] = []

    /// This method is called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the table view
        setupTableView()

        // Populate issues - This can be overridden by subclasses
        loadIssues()
    }

    /// Sets up the table view and registers the custom cell.
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self

        // Register the custom issue cell
        tableView.register(IssueTableViewCell.self, forCellReuseIdentifier: "IssueTableViewCell")

        // Add table view to the main view
        view.addSubview(tableView)
    }

    /// Loads the issues into the array. Subclasses will override this.
    func loadIssues() {
        // Subclasses will implement their own list of issues
    }

    // MARK: - TableView DataSource

    /// Returns the number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    /// Provides the table view cell for each issue and configures its content.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell", for: indexPath) as? IssueTableViewCell else {
            return UITableViewCell()
        }

        let issue = issues[indexPath.row]

        // Configure the cell, passing the functions to move forward and backward between boards.
        cell.configure(with: issue,
                       onMoveToNext: { [weak self] in
            self?.moveIssueToNextBoard(issue: issue, indexPath: indexPath)
        },
                       onMoveToPrevious: { [weak self] in
            self?.moveIssueToPreviousBoard(issue: issue, indexPath: indexPath)
        })

        return cell
    }
    
    // MARK: - Movement Methods

    /// Moves an issue to the next board (Next phase) and removes it from the current board.
    /// - Parameters:
    ///   - issue: The issue to move.
    ///   - indexPath: The indexPath of the issue to be removed from the current table.
    func moveIssueToNextBoard(issue: Issue, indexPath: IndexPath) {
        // Remove issue from the current board
        issues.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // Find the next view controller (e.g., NextViewController)
        if let nextVC = parent?.children.first(where: { $0 is NextViewController }) as? NextViewController {
            nextVC.addIssue(issue)
        }
    }

    /// Moves an issue to the previous board (if applicable) and removes it from the current board.
    /// - Parameters:
    ///   - issue: The issue to move.
    ///   - indexPath: The indexPath of the issue to be removed from the current table.
    func moveIssueToPreviousBoard(issue: Issue, indexPath: IndexPath) {
        // Remove issue from the current board
        issues.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // Find the previous view controller (if applicable)
        if let previousVC = parent?.children.first(where: { $0 is BacklogViewController }) as? BacklogViewController {
            previousVC.addIssue(issue)
        }
    }
}
