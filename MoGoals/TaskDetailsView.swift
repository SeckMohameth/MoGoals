import SwiftUI

struct TaskDetailsView: View {
    // MARK: - Properties
    let task: Task
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddSubtask = false
    
    // MARK: - View
    var body: some View {
        List {
            // Task Information Section
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    if !task.details.isEmpty {
                        Text(task.details)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(task.isCompleted ? .green : .gray)
                            .onTapGesture {
                                withAnimation {
                                    task.isCompleted.toggle()
                                }
                            }
                        Text(task.isCompleted ? "Completed" : "In Progress")
                            .font(.subheadline)
                            .foregroundStyle(task.isCompleted ? .green : .gray)
                    }
                    
                    if !task.subTasks.isEmpty {
                        Divider()
                        ProgressView(value: task.progress) {
                            Text("\(Int(task.progress * 100))% Complete")
                                .font(.caption)
                        }
                        .tint(.blue)
                    }
                }
            }
            
            // Subtasks Section
            Section {
                if task.subTasks.isEmpty {
                    ContentUnavailableView {
                        Label("No Subtasks", systemImage: "list.bullet.indent")
                    } description: {
                        Text("Break down this task into smaller steps")
                    } actions: {
                        Button(action: { showingAddSubtask = true }) {
                            Text("Add Subtask")
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    ForEach(task.subTasks) { subtask in
                        HStack {
                            Image(systemName: subtask.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(subtask.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        subtask.isCompleted.toggle()
                                    }
                                }
                            VStack(alignment: .leading) {
                                Text(subtask.title)
                                    .strikethrough(subtask.isCompleted)
                                if !subtask.details.isEmpty {
                                    Text(subtask.details)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteSubtask)
                }
            } header: {
                HStack {
                    Text("Subtasks")
                    Spacer()
                    Text("\(task.subTasks.count) total")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
        }
        .navigationTitle(task.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: { showingAddSubtask = true }) {
                Image(systemName: "plus.circle.fill")
            }
        }
        .sheet(isPresented: $showingAddSubtask) {
            SubtaskFormView(task: task)
        }
    }
    
    // MARK: - Functions
    private func deleteSubtask(at offsets: IndexSet) {
        for index in offsets {
            let subtask = task.subTasks[index]
            task.subTasks.remove(at: index)
            modelContext.delete(subtask)
        }
    }
}

#Preview {
    let task = Task(title: "Sample Task", details: "A sample task for preview")
    return NavigationStack {
        TaskDetailsView(task: task)
    }
    .modelContainer(for: Goal.self, inMemory: true)
}
