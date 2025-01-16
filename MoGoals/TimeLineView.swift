//
//  TimeLineView.swift
//  MoGoals
//
//  Created by Mohameth Seck on 1/9/25.
//

import SwiftUI

// Timeline item model
struct TimelineItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let isCompleted: Bool
    let isInProgress: Bool
    
    // Implement Equatable
    static func == (lhs: TimelineItem, rhs: TimelineItem) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.isCompleted == rhs.isCompleted &&
               lhs.isInProgress == rhs.isInProgress
    }
}

struct TimeLineView: View {
    @State private var items: [TimelineItem] = [
        TimelineItem(title: "UI and Site Development", isCompleted: true, isInProgress: false),
        TimelineItem(title: "Advisory and team build out", isCompleted: false, isInProgress: true),
        TimelineItem(title: "Community structure", isCompleted: false, isInProgress: false),
        TimelineItem(title: "Site Drop", isCompleted: false, isInProgress: false),
        TimelineItem(title: "Voting system implementation", isCompleted: false, isInProgress: false),
        TimelineItem(title: "Prize pool announcement", isCompleted: false, isInProgress: false),
        TimelineItem(title: "Open The Whitelist for Subscriptions", isCompleted: false, isInProgress: false),
        TimelineItem(title: "First Collection Mint date announced", isCompleted: false, isInProgress: false)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Roadmap")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading, spacing: 40) {
                    ForEach(items) { item in
                        HStack(alignment: .center, spacing: 15) {
                            // Timeline line with dot
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 2)
                                    .frame(height: 24)
                                
                                Circle()
                                    .fill(item.isCompleted ? Color.green :
                                          item.isInProgress ? Color.orange : Color.gray.opacity(0.3))
                                    .frame(width: 20, height: 20)
                                
                                if item != items.last {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 2)
                                        .frame(height: 24)
                                }
                            }
                            
                            // Content
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .padding(.leading, 8)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    TimeLineView()
}
