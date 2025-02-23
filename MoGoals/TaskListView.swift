//import SwiftUI
//import SwiftData
//
//struct TaskListView: View {
//    // MARK: - Properties
//    let goal: Goal  // Changed from @ObservedObject to regular property
//    @Environment(\.modelContext) private var modelContext
//    @State private var showingAddTask = false
//    @State private var selectedTask: Task? = nil
//    
//    // MARK: - View
//    var body: some View {
//        List {
//            Section {
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(goal.details)
//                        .foregroundStyle(.secondary)
//                    ProgressView(value: goal.progress) {
//                        Text("\(Int(goal.progress * 100))% Complete")
//                            .font(.caption)
//                    }
//                }
//            }
//            
//            Section("Tasks") {
//                if goal.tasks.isEmpty {
//                    ContentUnavailableView("No Tasks",
//                                         systemImage: "checklist",
//                                         description: Text("Tap + to add your first task"))
//                } else {
//                    ForEach(goal.tasks) { task in
//                        TaskRow(task: task)
//                            .swipeActions(edge: .trailing) {
//                                Button(role: .destructive) {
//                                    deleteTask(task)
//                                } label: {
//                                    Label("Delete", systemImage: "trash")
//                                }
//                            }
//                            .swipeActions(edge: .leading) {
//                                Button {
//                                    selectedTask = task
//                                } label: {
//                                    Label("Edit", systemImage: "pencil")
//                                }
//                                .tint(.orange)
//                            }
//                    }
//                }
//            }
//        }
//        .navigationTitle(goal.title)
//        .toolbar {
//            Button(action: { showingAddTask = true }) {
//                Image(systemName: "plus")
//            }
//        }
//        .sheet(isPresented: $showingAddTask) {
//            TaskFormView(goal: goal)
//        }
//        .sheet(item: $selectedTask) { task in
//            TaskFormView(goal: goal, task: task)
//        }
//    }
//    
//    // MARK: - Functions
//    private func deleteTask(_ task: Task) {
//        if let index = goal.tasks.firstIndex(where: { $0.id == task.id }) {
//            goal.tasks.remove(at: index)
//            modelContext.delete(task)
//        }
//    }
//}
//
//struct TaskRow: View {
//    let task: Task  // Changed from @ObservedObject to regular property
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
//                    .foregroundStyle(task.isCompleted ? .green : .gray)
//                Text(task.title)
//                    .strikethrough(task.isCompleted)
//                Spacer()
//                Text("\(task.subTasks.count) subtasks")
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//            }
//            if !task.details.isEmpty {
//                Text(task.details)
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//            }
//            if !task.subTasks.isEmpty {
//                ProgressView(value: task.progress)
//                    .progressViewStyle(.linear)
//                    .frame(height: 2)
//            }
//        }
//    }
//}
//
//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Goal.self, configurations: config)
//    
//    let sampleGoal = Goal(title: "Sample Goal", details: "A sample goal for preview")
//    return TaskListView(goal: sampleGoal)
//        .modelContainer(container)
//}
