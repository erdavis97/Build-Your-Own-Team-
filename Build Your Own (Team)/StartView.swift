//
//  StartView.swift
//  Build Your Own (Team)
//
//  Created by Ethan Davis on 4/16/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                VStack {
                    CustomText(text: "Title (TBD)")
                        .padding(60)
                    NavigationLink(destination: ContentView(), label: {
                        Text("Start")
                    })
                        .padding(100)
                }
            }
        }
    }
}

#Preview {
    StartView()
}

struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Futura-Bold", size: 70))
    }
}
