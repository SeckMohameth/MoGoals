//
//  GoalRow.swift
//  MoGoals
//
//  Created by Mohameth Seck on 1/8/25.
//
import SwiftUI

struct GoalRow: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("Name of the goal")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
            }
            Text("Description of the goal goal")
                .fontWeight(.light)
            Text("Due: 1/8/25")
        }
        .background(Color.secondary)
        .padding()
    }
}

#Preview {
    GoalRow()
}
