import SwiftUI

struct TaskRow: View {
    // MARK: - Properties
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.isCompleted ? .green : .gray)
                    .onTapGesture {
                        task.isCompleted.toggle()
                    }
                Text(task.title)
                    .strikethrough(task.isCompleted)
                Spacer()
                Text("\(task.subTasks.count) subtasks")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            if !task.details.isEmpty {
                Text(task.details)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            if !task.subTasks.isEmpty {
                ProgressView(value: task.progress)
                    .progressViewStyle(.linear)
                    .frame(height: 2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TaskRow(task: Task(title: "Sample Task", details: "A sample task"))
        .padding()
}

