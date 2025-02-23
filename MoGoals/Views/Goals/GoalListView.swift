//
//  GoalListView.swift
//  MoGoals
//
//  Created by Mohameth Seck on 2/23/25.
//

import SwiftUI
import SwiftData

struct GoalListView: View {
    // MARK: - Properties
    @Query(sort: \Goal.dueDate) private var goals: [Goal]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddGoal = false
    @State private var selectedGoal: Goal? = nil
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            ZStack {
                if goals.isEmpty {
                    // Empty state view
                    VStack(spacing: 20) {
                        Image(systemName: "target")
                            .font(.system(size: 60))
                            .foregroundStyle(.gray)
                            .symbolEffect(.bounce)
                        
                        Text("No Goals Yet")
                            .font(.title2.bold())
                        
                        Text("Tap + to add your first goal")
                            .foregroundStyle(.gray)
                    }
                } else {
                    // Updated goals list with navigation
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(goals) { goal in
                                NavigationLink {
                                    GoalDetailsView(goal: goal)
                                } label: {
                                    GoalRow(goal: goal)
                                        .padding(.horizontal)
                                        .contextMenu {
                                            Button(action: { selectedGoal = goal }) {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            Button(role: .destructive, action: { deleteGoal(goal) }) {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("My Goals")
            .toolbar {
                Button(action: { showingAddGoal = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
            }
            // Sheet for adding new goal
            .sheet(isPresented: $showingAddGoal) {
                GoalFormView()
            }
            .sheet(item: $selectedGoal) { goal in
                GoalFormView(goal: goal)
            }
        }
    }
    
    // MARK: - Functions
    private func deleteGoal(_ goal: Goal) {
        modelContext.delete(goal)
    }
}

#Preview {
    GoalListView()
        .modelContainer(for: Goal.self, inMemory: true)
}
