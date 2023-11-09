//
//  CircleGroupView.swift
//  RestartApp
//
//  Created by Nilam Shah on 08/11/23.
//

import SwiftUI

struct CircleGroupView: View {
    @State var sheetColor: Color
    @State var sheetOpacity: Double
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack() {
            Circle()
                .stroke(sheetColor.opacity(sheetOpacity), lineWidth: 40.0)
                .frame(width: 260, height: 260, alignment: .center)
            
            Circle()
                .stroke(sheetColor.opacity(sheetOpacity), lineWidth: 80.0)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

#Preview {
    ZStack {
        Color.teal.background().ignoresSafeArea()
        
        CircleGroupView(sheetColor: .red, sheetOpacity: 0.2)
    }
    
}
