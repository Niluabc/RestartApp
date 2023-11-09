//
//  ContentView.swift
//  RestartApp
//
//  Created by Nilam Shah on 07/11/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnbardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnbardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
