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
                Image("level1")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                VStack {
                    CustomText(text: "Title (TBD)")
                        .padding(68)
                    NavigationLink(destination: MovingBackground(), label: {
                        CustomLink(link: "Tap Here")
                    })
                    .padding(79)
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

struct CustomLink: View {
    let link: String
    var body: some View {
        Text(link).font(Font.custom("", size: 40)).fontWeight(.heavy).foregroundColor(Color.black)
    }
}
