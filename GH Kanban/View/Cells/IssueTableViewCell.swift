import UIKit

/// IssueTableViewCell
/// This class is a custom UITableViewCell to display issue details in the Kanban board.
/// It handles the title, issue information, and navigation arrow button.

class IssueTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    /// Label to display the title of the issue
    let issueTitleLabel = UILabel()
    
    /// Label to display additional info about the issue
    let issueInfoLabel = UILabel()
    
    /// Button with an arrow symbol to navigate between Kanban stages
    let arrowButton = UIButton()
    
    // MARK: - Initialization
    
    /// This method is called when the cell is initialized programmatically.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    /// This method is called when the cell is initialized from a storyboard or xib.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    
    /// This method sets up the UI elements and their constraints.
    private func setupUI() {
        // Set up the issue title label
        issueTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        issueTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(issueTitleLabel)
        
        // Set up the issue info label
        issueInfoLabel.font = UIFont.systemFont(ofSize: 14)
        issueInfoLabel.textColor = .gray
        issueInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(issueInfoLabel)
        
        // Set up the arrow button with an icon
        arrowButton.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        arrowButton.tintColor = .systemGreen
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowButton)
        
        // Set up the constraints for the labels and button
        NSLayoutConstraint.activate([
            // Constraints for the issue title label
            issueTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            issueTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            // Constraints for the issue info label
            issueInfoLabel.topAnchor.constraint(equalTo: issueTitleLabel.bottomAnchor, constant: 5),
            issueInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            issueInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            // Constraints for the arrow button
            arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            arrowButton.widthAnchor.constraint(equalToConstant: 40),
            arrowButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Configure Cell
    
    /// This method configures the cell with the issue data.
    /// - Parameter issue: The issue model containing the data to display.
    func configure(with issue: Issue) {
        issueTitleLabel.text = issue.title
        issueInfoLabel.text = issue.info
    }
}
