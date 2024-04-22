import SwiftUI

struct MovingBackground: View {
    @State private var xOffset: CGFloat = 0
    @State private var objPosition = 0
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect() // Creates timer
    
    var body: some View {
        GeometryReader { geometry in // This geometry reader privides info on the geometry of the photos inside of it. This helps us more easily resize the images
            ZStack {
                ForEach(0..<2) { index in
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffset + CGFloat(index) * geometry.size.width, y: 0) // This allows the background to fill the whole screen and allows it to stay fullscreen when the background moves
                } // For loop for the moving background
                
                Rectangle()
                    .fill(.red)
                    .border(Color.black)
                    .frame(width: 70, height: 70)
                    .position(CGPoint(x: 890.0 + Double((objPosition)), y: 310.0))
             //goes offscreen at x = - 35, so objPosition = -925
                
                Image("Character") // May be changed in final game
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3) // This adjusts how far left or right the character is
                    .offset(x: -geometry.size.width * 0.35, y: geometry.size.height * 0.29) // This adjusts the height of the character
            }
            .onReceive(timer) { _ in
                xOffset -= 1 // Every time the timer ticks, it moves the background over towards the left, creating the effect that its moving
                objPosition -= 6
                if objPosition <= -925 {
                    objPosition = 0
                }
                if xOffset <= -geometry.size.width {
                    xOffset = 0
                }
            }
            .clipped()
        }
        .edgesIgnoringSafeArea(.all) // Makes it full screen
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovingBackground()
    }
}
