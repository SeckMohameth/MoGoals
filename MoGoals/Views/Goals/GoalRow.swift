//
//  GoalRow.swift
//  MoGoals
//
//  Created by Mohameth Seck on 1/8/25.
//

import SwiftUI

struct GoalRow: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(goal.title)
                    .font(.headline)
                Spacer()
                Text(goal.dueDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            if !goal.details.isEmpty {
                Text(goal.details)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            HStack {
                ProgressView(value: goal.progress) {
                    Text("\(Int(goal.progress * 100))%")
                        .font(.caption2)
                }
                Text("\(goal.tasks.count) tasks")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color(.systemBackground))
            .shadow(radius: 2))
    }
}

#Preview {
    GoalRow(goal: Goal(title: "Sample Goal", details: "A sample goal for preview"))
        .padding()
        .background(Color(.systemGroupedBackground))
}
