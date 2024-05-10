//
//  Build_Your_Own__Team_App.swift
//  Build Your Own (Team)
//
//  Created by Ethan Davis on 4/12/24.
//
import SwiftUI

@main
struct Build_Your_Own_Team_App: App {
    @State private var character = "Monkey" // Initialize the character variable

    var body: some Scene {
        WindowGroup {
            StartView(character: $character) // Pass the character as a binding
        }
    }
}

