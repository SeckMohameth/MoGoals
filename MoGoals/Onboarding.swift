//
//  Onboarding.swift
//  MoGoals
//
//  Created by Mohameth Seck on 1/7/25.
//

import SwiftUI


struct Onboarding: View {
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("welcomeImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                LinearGradient(
                    gradient: Gradient(colors:[.black.opacity(0.7), .black.opacity(0.4)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("MoGoals")
                        .font(.system(size: 46))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("Helping you map out MoPlans")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                        .foregroundStyle(.white.opacity(0.9))
                        
                    Text("Set personal goals, track your progressm and celebrate you achievements. Your companion on the journey to success!")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(.horizontal, 32)
                    
                    Spacer()
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Get Started")
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 55)
                                                    .background(Color.white)
                                                    .cornerRadius(10)
                                                    .padding(.horizontal, 32)
                    }
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
