import UIKit

/// IssueTableViewCell
/// This custom table view cell is used to display information about a GitHub issue.
/// It includes buttons to move the issue to the next or previous phase in the Kanban board.

class IssueTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    let issueTitleLabel = UILabel()  // Label to display the issue's title
    let issueInfoLabel = UILabel()   // Label to display additional info like date, comments, and issue number
    let arrowRightButton = UIButton()  // Button to move the issue to the next phase
    let arrowLeftButton = UIButton()   // Button to move the issue to the previous phase
    
    // Callbacks to handle moving the issue between phases
    var onMoveToNext: (() -> Void)?  // Called when the issue is moved to the next phase
    var onMoveToPrevious: (() -> Void)?  // Called when the issue is moved to the previous phase

    // MARK: - Initialization
    /// Initializes the cell programmatically.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()  // Set up the UI elements
    }
    
    /// Initializes the cell from a storyboard or XIB file.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()  // Set up the UI elements
    }
    
    // MARK: - Setup UI
    /// Sets up the user interface of the cell, including labels and buttons.
    private func setupUI() {
        // Configure the issue title label
        issueTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        issueTitleLabel.numberOfLines = 0  // Allow multiple lines for long titles
        issueTitleLabel.lineBreakMode = .byWordWrapping  // Break the text by word if necessary
        issueTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(issueTitleLabel)
        
        // Configure the issue info label (e.g., creation date, comments count, issue number)
        issueInfoLabel.font = UIFont.systemFont(ofSize: 14)
        issueInfoLabel.textColor = .gray
        issueInfoLabel.numberOfLines = 0
        issueInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(issueInfoLabel)
        
        // Configure the right arrow button to move the issue to the next phase
        arrowRightButton.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        arrowRightButton.tintColor = .systemGreen
        arrowRightButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowRightButton)
        
        // Configure the left arrow button to move the issue to the previous phase
        arrowLeftButton.setImage(UIImage(systemName: "arrow.left.circle.fill"), for: .normal)
        arrowLeftButton.tintColor = .systemRed
        arrowLeftButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowLeftButton)
        
        // Add action targets for the navigation buttons
        arrowRightButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        arrowLeftButton.addTarget(self, action: #selector(moveToPrevious), for: .touchUpInside)
        
        // Set up the constraints for the UI elements
        NSLayoutConstraint.activate([
            // Constraints for the issue title label
            issueTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            issueTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            issueTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowLeftButton.leadingAnchor, constant: -10),
            
            // Constraints for the issue info label
            issueInfoLabel.topAnchor.constraint(equalTo: issueTitleLabel.bottomAnchor, constant: 5),
            issueInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            issueInfoLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowLeftButton.leadingAnchor, constant: -10),
            issueInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Constraints for the right arrow button
            arrowRightButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowRightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            arrowRightButton.widthAnchor.constraint(equalToConstant: 40),
            arrowRightButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Constraints for the left arrow button
            arrowLeftButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowLeftButton.trailingAnchor.constraint(equalTo: arrowRightButton.leadingAnchor, constant: -15),
            arrowLeftButton.widthAnchor.constraint(equalToConstant: 40),
            arrowLeftButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // MARK: - Navigation Buttons
    /// Action for the right arrow button, calls the `onMoveToNext` callback.
    @objc private func moveToNext() {
        onMoveToNext?()  // Call the callback to move to the next phase
    }

    /// Action for the left arrow button, calls the `onMoveToPrevious` callback.
    @objc private func moveToPrevious() {
        onMoveToPrevious?()  // Call the callback to move to the previous phase
    }
    
    // MARK: - Configure Cell
    /// Configures the cell with the issue data and assigns callbacks for navigation.
    /// - Parameters:
    ///   - issue: The issue to display in the cell.
    ///   - onMoveToNext: Callback triggered when moving to the next phase.
    ///   - onMoveToPrevious: Callback triggered when moving to the previous phase.
    func configure(with issue: Issue, onMoveToNext: @escaping () -> Void, onMoveToPrevious: @escaping () -> Void) {
        issueTitleLabel.text = issue.title
        issueInfoLabel.text = "Created at: \(issue.created_at) · \(issue.comments) comments · Issue #\(issue.number)"
        self.onMoveToNext = onMoveToNext
        self.onMoveToPrevious = onMoveToPrevious
    }
}
