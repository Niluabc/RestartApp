//
//  OnboardingView.swift
//  RestartApp
//
//  Created by Nilam Shah on 07/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimatingView: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue").background().ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.black)
                        .foregroundStyle(
                            Color(.white)
                        )
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("It's not how much we give but how much love we put into giving.")
                        .font(.system(size: 20))
                        .foregroundStyle(
                            Color(.white)
                        )
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                .opacity(isAnimatingView ? 1 : 0)
                .offset(y: isAnimatingView ? 0 : -40)
                .animation(.easeOut(duration: 1.0), value: isAnimatingView)
                
                ZStack {
                    CircleGroupView(sheetColor: .white, sheetOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeInOut(duration: 1.0), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimatingView ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimatingView)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 15)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1.0), value: imageOffset)
                } // MARK: Animation
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                            .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimatingView ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimatingView)
                        .opacity(indicatorOpacity)
                    ,
                    alignment: .bottom
                )
                
                Spacer()
                
                ZStack {
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    //MARK : Call To Action
                    Button {
                        
                    } label: {
                        Text("Get Started")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .offset(x: 20)
                            .foregroundStyle(
                                Color.white
                            )
                    }
                    
                    // MARK: Background circle
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    
                    // MARK: >> Circle
                    HStack {
                        ZStack {
                            Capsule()
                                .fill(Color("ColorRed"))
                            
                            Capsule()
                                .fill(Color.black.opacity(0.2))
                                .padding(8)
                            
                            Image(systemName: "chevron.forward.2")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold))
                        }
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(fileName: "chimeup", fileExtension: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimatingView ? 1 : 0)
                .offset(y: isAnimatingView ? 0 : 40)
                .animation(.easeOut(duration: 1.0), value: isAnimatingView)
                
                Spacer()
            }
        }
        .onAppear(perform: {
            isAnimatingView = true
        })
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnboardingView()
}
