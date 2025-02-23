import Foundation
import SwiftData

// MARK: - Goal Model
/// The top-level model representing a goal in the application.
/// Goals can contain multiple tasks and track overall progress.
@Model
class Goal {
    // MARK: - Properties
    /// The title of the goal
    var title: String
    /// Additional information about the goal
    var details: String
    /// The deadline for completing the goal
    var dueDate: Date
    /// Indicates whether the goal has been completed
    var isCompleted: Bool
    /// The date when the goal was created
    var createdDate: Date
    /// The date when the goal was last modified
    var lastModifiedDate: Date
    /// Collection of tasks associated with this goal
    /// When the goal is deleted, all associated tasks will also be deleted (cascade)
    @Relationship(deleteRule: .cascade) var tasks: [Task]
    
    // MARK: - Computed Properties
    /// Calculates the progress of the goal based on completed tasks
    /// Returns a value between 0.0 (no progress) and 1.0 (completed)
    var progress: Double {
        if tasks.isEmpty { return 0.0 }
        let totalTasks = Double(tasks.count)
        let completedTasks = Double(tasks.filter { $0.isCompleted }.count)
        return completedTasks / totalTasks
    }
    
    // MARK: - Initialization
    /// Creates a new Goal instance with optional default values
    init(title: String = "",
         details: String = "",
         dueDate: Date = .now,
         isCompleted: Bool = false,
         tasks: [Task] = [],
         createdDate: Date = .now,
         lastModifiedDate: Date = .now) {
        self.title = title
        self.details = details
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.tasks = tasks
        self.createdDate = createdDate
        self.lastModifiedDate = lastModifiedDate
    }
}

// MARK: - Task Model
/// Represents a task that belongs to a goal.
/// Tasks can contain multiple subtasks.
@Model
class Task {
    // MARK: - Properties
    /// The title of the task
    var title: String
    /// Additional information about the task
    var details: String
    /// Indicates whether the task has been completed
    var isCompleted: Bool
    /// The date when the task was created
    var createdDate: Date
    /// The date when the task was last modified
    var lastModifiedDate: Date
    /// Collection of subtasks associated with this task
    /// When the task is deleted, all associated subtasks will also be deleted (cascade)
    @Relationship(deleteRule: .cascade) var subTasks: [SubTask]
    
    // MARK: - Computed Properties
    /// Calculates the progress of the task based on completed subtasks
    /// If there are no subtasks, returns 1.0 if the task is completed, 0.0 otherwise
    var progress: Double {
        if subTasks.isEmpty { return isCompleted ? 1.0 : 0.0 }
        return Double(subTasks.filter { $0.isCompleted }.count) / Double(subTasks.count)
    }
    
    // MARK: - Initialization
    /// Creates a new Task instance with optional default values
    init(title: String = "",
         details: String = "",
         isCompleted: Bool = false,
         subTasks: [SubTask] = [],
         createdDate: Date = .now,
         lastModifiedDate: Date = .now) {
        self.title = title
        self.details = details
        self.isCompleted = isCompleted
        self.subTasks = subTasks
        self.createdDate = createdDate
        self.lastModifiedDate = lastModifiedDate
    }
}

// MARK: - SubTask Model
/// Represents the smallest unit of work in the application.
/// SubTasks belong to a Task and can only be marked as completed or incomplete.
@Model
class SubTask {
    // MARK: - Properties
    /// The title of the subtask
    var title: String
    /// Additional information about the subtask
    var details: String
    /// Indicates whether the subtask has been completed
    var isCompleted: Bool
    /// The date when the subtask was created
    var createdDate: Date
    /// The date when the subtask was last modified
    var lastModifiedDate: Date
    
    // MARK: - Initialization
    /// Creates a new SubTask instance with optional default values
    init(title: String = "",
         details: String = "",
         isCompleted: Bool = false,
         createdDate: Date = .now,
         lastModifiedDate: Date = .now) {
        self.title = title
        self.details = details
        self.isCompleted = isCompleted
        self.createdDate = createdDate
        self.lastModifiedDate = lastModifiedDate
    }
}
