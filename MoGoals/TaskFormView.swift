import SwiftUI

struct TaskFormView: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let goal: Goal  // Changed from @ObservedObject to regular property
    var task: Task? // If provided, we're editing

    @State private var title = ""
    @State private var details = ""
    @State private var showingSubtaskSheet = false

    // MARK: - View
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .font(.headline)
                    TextField("Details", text: $details, axis: .vertical)
                        .lineLimit(3...6)
                        .font(.subheadline)
                } header: {
                    Label("Task Information", systemImage: "checklist")
                        .foregroundStyle(.blue)
                        .font(.headline)
                }

                if let task = task {
                    Section {
                        ForEach(task.subTasks) { subtask in
                            HStack {
                                Image(systemName: subtask.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(subtask.isCompleted ? .green : .gray)
                                    .onTapGesture {
                                        subtask.isCompleted.toggle()
                                    }
                                Text(subtask.title)
                                    .strikethrough(subtask.isCompleted)
                            }
                        }
                        .onDelete(perform: deleteSubtask)

                        Button(action: { showingSubtaskSheet = true }) {
                            Label("Add Subtask", systemImage: "plus.circle")
                                .foregroundStyle(.blue)
                        }
                    } header: {
                        Label("Subtasks", systemImage: "list.bullet.indent")
                            .foregroundStyle(.blue)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle(task == nil ? "New Task" : "Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.secondary)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveTask()
                    }
                    .disabled(title.isEmpty)
                    .bold()
                }
            }
            .sheet(isPresented: $showingSubtaskSheet) {
                SubtaskFormView(task: task!)
            }
            .onAppear {
                if let task = task {
                    title = task.title
                    details = task.details
                }
            }
        }
    }

    // MARK: - Functions
    private func saveTask() {
        if let existingTask = task {
            // Update existing task
            existingTask.title = title
            existingTask.details = details
            existingTask.lastModifiedDate = .now
        } else {
            // Create new task
            let newTask = Task(title: title, details: details)
            goal.tasks.append(newTask)
        }
        dismiss()
    }

    private func deleteSubtask(at offsets: IndexSet) {
        guard let task = task else { return }
        for index in offsets {
            let subtask = task.subTasks[index]
            modelContext.delete(subtask)
            task.subTasks.remove(at: index)
        }
    }
}

#Preview {
    let goal = Goal(title: "Sample Goal")
    return TaskFormView(goal: goal)
        .modelContainer(for: Goal.self, inMemory: true)
}
