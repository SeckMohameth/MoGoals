//
//  ContentView.swift
//  MoGoals
//
//  Created by Mohameth Seck on 1/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        if !hasSeenOnboarding {
            Onboarding()
        } else {
            MainView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Goal.self, inMemory: true)
}
