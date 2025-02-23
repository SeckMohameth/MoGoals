//
//  MoGoalsApp.swift
//  MoGoals
//
//  Created by Mohameth Seck on 1/7/25.
//

import SwiftUI
import SwiftData

@main
struct MoGoalsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Goal.self)
    }
}
