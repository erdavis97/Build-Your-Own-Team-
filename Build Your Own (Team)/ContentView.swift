import SwiftUI

struct MovingBackground: View {
    @State private var xOffset: CGFloat = 0 // Position of the background that increases every time the timer ticks
    @State private var objPosition = 0.0 // Position of the block that increases every time the timer ticks
    @State private var objWidth = 50.0
    @State private var objHeight = 50.0
    @State var score = 0.0 // Will eventually be used to strore the score
    
    @State private var jumpOffset: CGFloat = 0 // New state variable to control the character's jump
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() // Creates timer
    
    var body: some View {
        GeometryReader { geometry in // This geometry reader provides info on the geometry of the photos inside of it. This helps us more easily resize the images
            ZStack {
                ForEach(0..<2) { index in
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffset + CGFloat(index) * geometry.size.width, y: 0) // This allows the background to fill the whole screen and allows it to stay fullscreen when the background moves
                } // For loop for the moving background
                
                Rectangle()
                    .fill(Color.red)
                    .border(Color.black)
                    .frame(width: objWidth, height: objHeight)
                    .position(CGPoint(x: 890.0 + Double((objPosition)), y: 322.0)) // This is our test rectangle for now that can later be swapped out for obsticals. it moves across the screen and when it exits the left side, another one comes out the right side
                
                Image("Character") // May be changed in final game
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3) // This adjusts how far left or right the character is
                    .offset(x: -geometry.size.width * 0.35, y: geometry.size.height * 0.29 + jumpOffset) // This adjusts the height of the character
                    .gesture(
                        TapGesture().onEnded {
                            jump()
                        } // When the character is tapped, it calls the jump function whih allows the character to jump
                    )
            }
            VStack{
                var Num = String(Int(score))
                CustomText(text: "Score: " +  Num)
            }
            
            .onReceive(timer) { _ in
                xOffset -= 1 // Every time the timer ticks, it moves the background over towards the left, creating the effect that its moving
                objPosition -= 4 // Moves object to the left every time the timer ticks
                if objPosition <= -925 {
                    objPosition = 0
                    setObject()
                }
                
                if xOffset <= -geometry.size.width {
                    xOffset = 0
                }
                score += 0.05
            }
            .clipped()
        }
        .edgesIgnoringSafeArea(.all) // Makes it full screen
    }
    
    func setObject() {
        objWidth = Double.random(in: 25...100)
        objHeight = Double.random(in: 25...100)
    }
    
    func jump() {
        withAnimation(.easeInOut(duration: 0.3)) { // Animation allows the character to smoothly jump on the screen
            jumpOffset = -150 // How high the character jumps
        }
        // Dispatch queue is used to allow the jump to happen at the time of the click and finish executing 0.35 seconds after
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { // How long the character is delayed in the air for.
            withAnimation(.easeInOut(duration: 0.5)) { //how fast the character comes down
                jumpOffset = 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovingBackground()
    }
}
