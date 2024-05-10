import SwiftUI

struct StartView: View {
    @Binding var character: String

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
                    
                    NavigationLink("START GAME", destination: MovingBackground(character: $character).navigationBarBackButtonHidden(true))
                        .background(Rectangle().frame(width: 150.0, height: 50.0) .foregroundColor(.yellow).border(Color.black, width: 2.5))
                        .position(CGPoint(x: 570.0, y: -62.0))
                        .padding(79)
                }
                
                Image(character).resizable().frame(width: 130, height: 130, alignment: .topLeading).position(CGPoint(x: 370.0, y: 250.0))
                
                NavigationLink("SELECT CHARACTER", destination: SelectView(character: $character).navigationBarBackButtonHidden(true))
                    .background(Rectangle().frame(width: 200.0, height: 50.0) .foregroundColor(.yellow).border(Color.black, width: 2.5))
                    .position(CGPoint(x: 100.0, y: 250.0))
            }
        }
    }
}

struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Futura-Bold", size: 70))
    }
}
