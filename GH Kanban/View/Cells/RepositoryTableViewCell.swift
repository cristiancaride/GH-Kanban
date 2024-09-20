import UIKit

/// RepositoryTableViewCell
/// This class represents a custom table view cell used to display repository information in the app.
/// It contains a label for the repository name, a label for the author, and a button to perform actions (e.g., add to favorites).
class RepositoryTableViewCell: UITableViewCell {

    /// Label that displays the name of the repository.
    @IBOutlet weak var repoNameLabel: UILabel!

    /// Label that displays the name of the author/owner of the repository.
    @IBOutlet weak var repoAuthorLabel: UILabel!

    /// Button that can trigger an action, such as adding the repository to a list or favorites.
    @IBOutlet weak var addButtonImageView: UIButton!
}
