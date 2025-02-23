import SwiftUI

struct GoalFormView: View {
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var goal: Goal? // If provided, we're editing. If nil, we're creating
    
    @State private var title = ""
    @State private var details = ""
    @State private var dueDate = Date()
    
    // Added color scheme for theme
    private let accentColor = Color.blue
    private let backgroundColor = Color(.systemGroupedBackground)
    
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
                    Label("Goal Information", systemImage: "target")
                        .foregroundStyle(.blue)
                        .font(.headline)
                        .padding(.bottom, 8)
                }
                
                Section {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .tint(.blue)
                } header: {
                    Label("Timeline", systemImage: "calendar")
                        .foregroundStyle(.blue)
                        .font(.headline)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(goal == nil ? "New Goal" : "Edit Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.secondary)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveGoal) {
                        Text("Save")
                            .bold()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .onAppear {
                if let goal = goal {
                    // Pre-fill form if editing
                    title = goal.title
                    details = goal.details
                    dueDate = goal.dueDate
                }
            }
        }
    }
    
    // MARK: - Functions
    private func saveGoal() {
        if let existingGoal = goal {
            // Update existing goal
            existingGoal.title = title
            existingGoal.details = details
            existingGoal.dueDate = dueDate
            existingGoal.lastModifiedDate = .now
        } else {
            // Create new goal
            let newGoal = Goal(title: title,
                              details: details,
                              dueDate: dueDate)
            modelContext.insert(newGoal)
        }
        dismiss()
    }
}

#Preview {
    GoalFormView()
        .modelContainer(for: Goal.self, inMemory: true)
}
