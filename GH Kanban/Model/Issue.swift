/// Issue
/// Represents a GitHub issue with information like title, number, date, and comments.
/// Interaction: Used by the ViewModel to organize issues into the kanban board columns.

import Foundation

struct Issue {
    let title: String
    let info: String
}
