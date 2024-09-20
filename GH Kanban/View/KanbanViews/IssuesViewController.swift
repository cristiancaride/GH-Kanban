import UIKit

/// IssuesViewController
/// This class handles displaying a list of issues in a table view.
/// It will be subclassed by specific view controllers like BacklogViewController, NextViewController, etc.

class IssuesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    /// Table view to display the list of issues
    let tableView = UITableView()

    /// Array of issues that will populate the table
    var issues: [Issue] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the table view
        setupTableView()

        // Populate issues - This can be overridden by subclasses
        loadIssues()
    }

    /// Sets up the table view and registers the custom cell
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell", for: indexPath) as? IssueTableViewCell else {
            return UITableViewCell()
        }

        let issue = issues[indexPath.row]
        cell.configure(with: issue)

        return cell
    }
}
