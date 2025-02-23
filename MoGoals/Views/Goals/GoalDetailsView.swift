import SwiftUI
import SwiftData

struct GoalDetailsView: View {
    // MARK: - Properties remain the same
    let goal: Goal
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddTask = false
    @State private var selectedTask: Task? = nil
    
    // MARK: - View
    var body: some View {
        List {
            // Goal Information Section remains the same
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text(goal.details)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Due")
                                .foregroundStyle(.secondary)
                            Text(goal.dueDate.formatted(date: .abbreviated, time: .omitted))
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Text("Progress")
                                .foregroundStyle(.secondary)
                            Text("\(Int(goal.progress * 100))%")
                                .fontWeight(.medium)
                        }
                    }
                    .font(.caption)
                    
                    ProgressView(value: goal.progress)
                        .tint(.blue)
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
            
            // Tasks Section with navigation to TaskDetailsView
            Section {
                if goal.tasks.isEmpty {
                    ContentUnavailableView {
                        Label("No Tasks", systemImage: "checklist")
                    } description: {
                        Text("Add tasks to track your progress")
                    } actions: {
                        Button(action: { showingAddTask = true }) {
                            Text("Add Task")
                        }
                        .buttonStyle(.bordered)
                    }
                    .listRowBackground(Color(.systemGroupedBackground))
                } else {
                    ForEach(goal.tasks) { task in
                        NavigationLink {
                            TaskDetailsView(task: task)
                        } label: {
                            TaskRow(task: task)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                withAnimation {
                                    deleteTask(task)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                selectedTask = task
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Tasks")
                    Spacer()
                    Text("\(goal.tasks.count) total")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
        }
        .navigationTitle(goal.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: { showingAddTask = true }) {
                Image(systemName: "plus.circle.fill")
            }
        }
        .sheet(isPresented: $showingAddTask) {
            TaskFormView(goal: goal)
        }
        .sheet(item: $selectedTask) { task in
            TaskFormView(goal: goal, task: task)
        }
    }
    
    // MARK: - Functions remain the same
    private func deleteTask(_ task: Task) {
        if let index = goal.tasks.firstIndex(where: { $0.id == task.id }) {
            goal.tasks.remove(at: index)
            modelContext.delete(task)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Goal.self, configurations: config)
    
    let sampleGoal = Goal(title: "Sample Goal", details: "A sample goal for preview")
    return NavigationStack {
        GoalDetailsView(goal: sampleGoal)
    }
    .modelContainer(container)
}
