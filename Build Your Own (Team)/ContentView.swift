//
//  ContentView.swift
//  Build Your Own (Team)
//
//  Created by Ethan Davis on 4/12/24.
//

// Ethan Scott's comment

import SwiftUI

struct MovingBackground: View {
    @State private var xOffset: CGFloat = 0
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<2) { index in
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffset + CGFloat(index) * geometry.size.width, y: 0)
                }
            }
            .onReceive(timer) { _ in
                xOffset -= 1 // Adjust the speed of movement by changing this value
                
                if xOffset <= -geometry.size.width {
                    xOffset = 0
                }
            }
            .clipped()
        }
    }
}

struct ContentView: View {
    var body: some View {
        MovingBackground()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

