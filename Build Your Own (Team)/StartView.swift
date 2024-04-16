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
            NavigationLink("Start", destination: ContentView())
        }
    }
}

#Preview {
    StartView()
}
