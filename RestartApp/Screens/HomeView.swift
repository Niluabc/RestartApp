//
//  HomeView.swift
//  RestartApp
//
//  Created by Nilam Shah on 07/11/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimatingView: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            // MARK: HEADER
            ZStack {
                CircleGroupView(sheetColor: .gray, sheetOpacity: 0.2)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimatingView ? 35 : -35)
                .animation(.easeOut(duration: 4.0).repeatForever(), value: isAnimatingView)
                
            }
            
            // MARK: Center
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.system(size: 20, weight: .light))
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    Color.secondary
                )
                .padding()
            
            // MARK: Footer
            Spacer()
            
            Button {
                withAnimation {
                    playSound(fileName: "success", fileExtension: "m4a")
                    isOnboardingViewActive = true
                }
            } label: {
                Image(systemName: "arrow.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimatingView = true
            })
        })
    }
}

#Preview {
    HomeView()
}
