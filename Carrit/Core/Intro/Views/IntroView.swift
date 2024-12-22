//
//  IntroView.swift
//  Carrit
//
//  Created by Marcelo Costa on 21/12/24.
//

import SwiftUI

struct IntroView: View {
    // MARK: - Animation Properties
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex = 0
    @State var showHomeView: Bool = false
    
    var body: some View {
        ZStack {
            if showHomeView {
                HomeApp()
                    .transition(.move(edge: .trailing))
            } else {
                ZStack{
                    Color("BG")
                        .ignoresSafeArea()
                    
                    IntroScreen()
                    
                    NavBar()
                    
                    WalkThroughScreens()
                        
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .leading))

            }
        }
        .animation(.easeInOut(duration: 0.35), value: showWalkThroughScreens)
    }
    // MARK: - WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
         
        GeometryReader {
            let size = $0.size
            
            ZStack {
                // MARK: - Walk Through Screens
                ForEach(intros.indices, id: \.self) { index in
                    ScreenView(size: size, index: index)
                }
                
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // MARK: - Next Button
            .overlay(alignment: .bottom) {
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1: 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("Sign Up")
                            .font(.custom(sansBold, size: 15))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                            .fill(Color("AppBlue"))
                    }
                    .onTapGesture {
                        //MARK: - Updating Index
                        if currentIndex == intros.count {
                            
                            showHomeView = true
                            
                        }else {
                            currentIndex += 1
                        }
                    }
                    .offset(y: isLast ? -40 : -90)
                
                    .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            }
            .overlay(alignment: .bottom, content: {
                let isLast = currentIndex == intros.count
                
                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .font(.custom(sansRegular, size: 14))
                        .foregroundStyle(.gray)
                    
                    Button("Login") {
                        
                    }
                    .font(.custom(sansBold, size: 14))
                    .foregroundStyle(Color("AppBlue"))
                }
                .offset(y: isLast ? -12 : 100)
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5 ), value: isLast)
            })
            .offset(y: showWalkThroughScreens ? 0 : size.height)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) -> some View{
        let intro = intros[index]
        
        VStack(spacing: 10){
            Text(intro.title)
                .font(.custom(sansBold, size: 28))
            // MARK: - Applying Offset For Each Screens's
                .offset(x: -size.width * CGFloat(currentIndex - index))
            // MARK: - Adding Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 400, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
        
    }
    
    // MARK: - Welcome Screen
    @ViewBuilder
    func WelcomeView(size: CGSize, index: Int) -> some View{
        VStack(spacing: 10){
            
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Welcome")
                .font(.custom(sansBold, size: 28))

                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("Order your daily fresh food with no stress with\nCurrit app.")
                .font(.custom(sansRegular, size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)

        }
        .offset(y: -30)
        
    }
    @ViewBuilder
    func NavBar() -> some View {
        let isLast = currentIndex == intros.count
        HStack {
            Button {
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScreens.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("AppBlue"))
            }
            
            Spacer()
            
            Button("Skip") {
                
                currentIndex = intros.count
                
            }
            .font(.custom(sansRegular, size: 14))
            .foregroundStyle(Color("AppBlue"))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader{
            let size = $0.size
            
            
            VStack(spacing: 10){
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height / 2)
                
                Text("Meditate")
                    .font(.custom(sansBold, size: 27))
                    .padding(.top, 55)
                
                Text(dummyText)
                    .font(.custom(sansRegular, size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Text("Let's Begin")
                    .font(.custom(sansSemiBold, size: 14))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundStyle(.white)
                    .background {
                        Capsule()
                            .fill(Color("AppBlue"))
                    }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // MARK: - Moving Up When Clicked
            .offset(y: showWalkThroughScreens ? -size.height : 0)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}

// MARK: - Home View
struct HomeApp: View {
    var body: some View {
        NavigationStack {
            Text("")
                .navigationTitle("Home")
        }
    }
}
    

