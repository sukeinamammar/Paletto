//
//  WelcomePage.swift
//  Paletto
//
//  Created by Gina Mahaz on 12/2/25.
//

import SwiftUI

struct WelcomePage: View {
/*@AppStorage("hasSeenWelcome")*/ @State var hasSeenWelcome: Bool = false
    
    var body: some View {
        if hasSeenWelcome {
                    ContentView()
                } else {
        ZStack {
            LinearGradient(colors: [.orange, .yellow, .green, .teal, .blue, .indigo, .purple, .red], startPoint: .top, endPoint: .bottom)
//                .hueRotation(.degrees(45))
                .ignoresSafeArea()
            VStack {
                
                Text("paletto")
                    .padding()
                    .font(Font.custom("Helvetica", size: 25))
                    .foregroundStyle(Color.white)
                //                    .glassEffect(.clear)
                Spacer()
                
                Text("play music with color")
                    .font(Font.custom("Silom", size: 25))
                    .bold()
                    .foregroundColor(.white)
                    .padding(20)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "paintpalette.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                            .padding(.trailing, 20)
                        Text("Explore chord progressions through their color counterparts")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                    .padding(20)
                    
                    HStack {
                        Image(systemName: "music.note.square.stack.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                            .padding(.trailing, 30)
                        Text("Enable prompt mode to experiment with color, sound, and words for more inspiration")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                    .padding(20)
                    
                    HStack {
                        Image(systemName: "brain.head.profile.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                            .padding(.trailing, 25)
                        Text("Use Paletto reflect on how sound, color, and emotions shape the way you create")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                        //                        .padding(.trailing)
                    }
                    .padding(20)
                }
                .padding(16)
                Spacer()
                
                Button(action: {
                    self.hasSeenWelcome = true
                }) {
                    Text("get started")
                        .font(Font.custom("Helvetica", size: 20))
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(Color.clear)
                        .cornerRadius(10)
                    Image(systemName: "arrow.right.circle.dotted")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                        .symbolEffect(.breathe)
                }
            }
            
            }
        
        }
    }
}

#Preview {
    WelcomePage()
}


