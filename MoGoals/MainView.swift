//
//  MainView.swift
//  MoGoals
//
//  Created by Mohameth Seck on 2/23/25.
//

import SwiftUI

struct MainView: View {
    // Added color scheme
    private let accentColor = Color.blue
    
    var body: some View {
        TabView {
            Tab("Goals", systemImage: "target") {
                GoalListView()
            }
            
            Tab("Stats", systemImage: "chart.bar.fill") {
                StatsView()
            }
        }
        .tint(accentColor)
    }
}

#Preview {
    MainView()
        .modelContainer(for: Goal.self, inMemory: true)
}

