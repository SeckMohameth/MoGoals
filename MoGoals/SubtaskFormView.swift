import SwiftUI

struct SubtaskFormView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    let task: Task
    
    @State private var title = ""
    @State private var details = ""
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .font(.headline)
                    TextField("Details", text: $details, axis: .vertical)
                        .lineLimit(2...4)
                        .font(.subheadline)
                } header: {
                    Label("Subtask Information", systemImage: "list.bullet.indent")
                        .foregroundStyle(.blue)
                        .font(.headline)
                }
            }
            .navigationTitle("New Subtask")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.secondary)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        saveSubtask()
                    }
                    .disabled(title.isEmpty)
                    .bold()
                }
            }
        }
    }
    
    // MARK: - Functions
    private func saveSubtask() {
        let subtask = SubTask(title: title, details: details)
        task.subTasks.append(subtask)
        dismiss()
    }
}

#Preview {
    let task = Task(title: "Sample Task")
    return SubtaskFormView(task: task)
        .modelContainer(for: Goal.self, inMemory: true)
}
