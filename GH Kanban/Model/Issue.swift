/// Issue
/// Represents a GitHub issue with details such as title, number, date, and comment count.
/// Interaction: This struct is used by the ViewModel to categorize issues into different Kanban board stages.

import Foundation

struct Issue: Codable, Equatable {
    let id: Int               // The unique identifier of the issue
    let title: String          // The title or headline of the issue
    let number: Int            // The issue number as assigned by GitHub
    let comments: Int          // The number of comments associated with the issue (from the GitHub API)
    let created_at: String     // The date when the issue was created (from the GitHub API)
    var state: String          // The current state of the issue, e.g., "backlog", "next", "doing", "done"
}
