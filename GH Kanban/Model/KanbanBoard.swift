/// KanbanBoard
/// Manages the state of the kanban board, including the columns backlog, next, doing, and done.
/// Interaction: The ViewModel interacts with this class to move issues between columns.

class KanbanBoard {
    var backlog: [Issue] = []
    var next: [Issue] = []
    var doing: [Issue] = []
    var done: [Issue] = []
    
    /// Moves an issue from one column to another.
    /// - Parameters:
    ///   - issue: The Issue object to be moved.
    ///   - fromColumn: The current column where the issue is located.
    ///   - toColumn: The destination column.
    
    func moveIssue(_ issue: Issue, fromColumn: Column, toColumn: Column) {
        // Logic for moving issues between columns (to be implemented)
    }
}

/// Enum representing the kanban board columns.
enum Column {
    case backlog, next, doing, done
}
