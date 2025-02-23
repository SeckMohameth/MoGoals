//
//  Onboarding.swift
//  MoGoals
//
//  Created by Mohameth Seck on 1/7/25.
//

import SwiftUI


struct Onboarding: View {
    
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    // Background layer
                    Color.black.ignoresSafeArea()
                    
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .purple.opacity(0.3),
                            .blue.opacity(0.2),
                            .black
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    // Content layer
                    VStack(spacing: 0) {
                        // Logo and app name section
                        VStack(spacing: 20) {
                            Image(systemName: "target")
                                .font(.system(size: 80))
                                .foregroundStyle(.white)
                                .symbolEffect(.bounce)
                            
                            Text("MoGoals")
                                .font(.system(size: 46, weight: .bold))
                                .foregroundStyle(.white)
                        }
                        .frame(height: geometry.size.height * 0.4)
                        
                        // Main content section
                        VStack(spacing: 24) {
                            // Tagline
                            Text("Helping you map out MoPlans")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundStyle(.white.opacity(0.9))
                            
                            // Description
                            Text("Set personal goals, track your progress, and celebrate your achievements. Your companion on the journey to success!")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .lineSpacing(8)
                                .foregroundStyle(.white.opacity(0.7))
                                .padding(.horizontal, 32)
                            
                            // Features list
                            VStack(alignment: .leading, spacing: 16) {
                                FeatureRow(icon: "checklist", text: "Create and track goals")
                                FeatureRow(icon: "chart.line.uptrend.xyaxis", text: "Monitor your progress")
                                FeatureRow(icon: "bell", text: "Get timely reminders")
                            }
                            .padding(.vertical, 20)
                        }
                        .frame(height: geometry.size.height * 0.4)
                        
                        // Button section
                        VStack {
                            Button {
                                withAnimation {
                                    hasSeenOnboarding = true
                                }
                            } label: {
                                Text("Get Started")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .padding(.horizontal, 32)
                            .padding(.top, 20)
                        }
                        .frame(height: geometry.size.height * 0.2)
                    }
                }
            }
        }
    }
}

// Feature row component
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 32)
            
            Text(text)
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    Onboarding()
}
