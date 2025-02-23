import SwiftUI
import SwiftData

struct StatsView: View {
    // MARK: - Properties remain the same
    @Query private var goals: [Goal]
    
    private let colors = [
        Color.blue,
        Color.green,
        Color.orange,
        Color.purple
    ]
    
    // Computed properties remain the same
    private var activeGoals: Int { goals.count }
    private var completedGoals: Int { goals.filter { $0.isCompleted }.count }
    private var totalTasks: Int { goals.reduce(0) { $0 + $1.tasks.count } }
    private var completedTasks: Int {
        goals.reduce(0) { $0 + $1.tasks.filter { $0.isCompleted }.count }
    }
    
    private var averageProgress: Double {
        guard !goals.isEmpty else { return 0 }
        return goals.reduce(0.0) { $0 + $1.progress } / Double(goals.count)
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Overview Cards
                    LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 16) {
                        StatCard(title: "Active Goals",
                                value: String(activeGoals),
                                icon: "target",
                                color: colors[0])
                        
                        StatCard(title: "Completed",
                                value: "\(completedGoals)/\(activeGoals)",
                                icon: "checkmark.circle.fill",
                                color: colors[1])
                        
                        StatCard(title: "Total Tasks",
                                value: String(totalTasks),
                                icon: "list.bullet",
                                color: colors[2])
                        
                        StatCard(title: "Tasks Done",
                                value: "\(completedTasks)/\(totalTasks)",
                                icon: "checkmark.circle",
                                color: colors[3])
                    }
                    .padding(.horizontal)
                    
                    // Progress Chart
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Goals Progress")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(goals) { goal in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(goal.title)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .lineLimit(1)
                                        
                                        Text("\(Int(goal.progress * 100))%")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        
                                        ProgressView(value: goal.progress)
                                            .tint(colors[Int(arc4random_uniform(UInt32(colors.count)))]) // Random color
                                    }
                                    .frame(width: 140)
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(color: .black.opacity(0.05), radius: 5)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Overall Progress Ring
                    VStack(spacing: 16) {
                        Text("Overall Progress")
                            .font(.headline)
                        
                        ZStack {
                            Circle()
                                .stroke(Color(.systemGray5), lineWidth: 20)
                                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                            
                            Circle()
                                .trim(from: 0, to: averageProgress)
                                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                .foregroundStyle(LinearGradient(colors: [.blue, .blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .rotationEffect(.degrees(-90))
                                .shadow(color: .blue.opacity(0.3), radius: 3, x: 0, y: 2)
                            
                            Text("\(Int(averageProgress * 100))%")
                                .font(.title.bold())
                                .foregroundStyle(.blue)
                        }
                        .frame(width: 200, height: 200)
                        .padding(.vertical)
                    }
                    .padding(.top)
                }
                .padding(.vertical)
            }
            .navigationTitle("Statistics")
            .background(.clear)
        }
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            
            VStack(spacing: 4) {
                Text(value)
                    .font(.title2.bold())
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview {
    StatsView()
        .modelContainer(for: Goal.self, inMemory: true)
}
