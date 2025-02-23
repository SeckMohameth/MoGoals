import Foundation
import SwiftData

@Model
class Goal {
    var title: String
    var description: String
    var dueDate: Date
    var isCompleted: Bool
    @Relationship(deleteRule: .cascade) var tasks: [Task]
    var progress: Double {
        if tasks.isEmpty { return 0 }
        return Double(tasks.filter { $0.isCompleted }.count) / Double(tasks.count)
    }
    
    init(title: String = "", description: String = "", dueDate: Date = .now, isCompleted: Bool = false, tasks: [Task] = []) {
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.tasks = tasks
    }
}

@Model
class Task {
    var title: String
    var isCompleted: Bool
    
    init(title: String = "", isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

