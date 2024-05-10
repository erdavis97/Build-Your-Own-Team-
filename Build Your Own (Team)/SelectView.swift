import SwiftUI

struct ContentView: View {
    @State private var character = "" // Shared @State variable

    var body: some View {
        VStack {
            SelectView(character: $character) // Pass the character as a binding
            MovingBackground(character: $character) 
            StartView(character: $character)
        }
    }
}

// SelectView with the character as a binding
struct SelectView: View {
    @Binding var character: String // Binding to the shared @State variable

    var body: some View {
        NavigationStack {
            ZStack {
                Image("level1").resizable().ignoresSafeArea()
                VStack {
                    CustomText(text: "Pick your character")
                    Spacer()
                    Image("Shelf").resizable()
                }
                Spacer()
                Image("Monkey").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 100.0, y: 155.0))
                Text("Monkey Boss").position(CGPoint(x: 100.0, y: 270.0)).onTapGesture {
                    character = "Monkey"
                }
                               
                Image("Warrior").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 250.0, y: 155.0))
                Text("Warrior").position(CGPoint(x: 250.0, y: 270.0)).onTapGesture {
                    character = "Warrior"
                }
                
                Image("Skull Knight").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 400.0, y: 155.0))
                Text("Skull Knight").position(CGPoint(x: 400.0, y: 270.0)).onTapGesture {
                    character = "Skull Knight"
                }
                
                Image("Evil Goblin").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 560.0, y: 155.0))
                Text("Evil Goblin").position(CGPoint(x: 560, y: 270.0)).onTapGesture {
                    character = "Evil Goblin"
                }
                NavigationLink("Return to Home", destination: StartView(character: $character).navigationBarBackButtonHidden(true)).position(CGPoint(x: 325.0, y: 300.0))
            }
        }
    }
}

