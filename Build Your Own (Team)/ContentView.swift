import SwiftUI

struct MovingBackground: View {
    // Background properties
    @State private var xOffset: CGFloat = 0 // Position of the background that increases every time the timer ticks
    @State private var objPosition = 0.0 // Position of the block that increases every time the timer ticks
    @State private var objWidth = 50.0
    @State private var objHeight = 50.0
    @State private var score = 90.0 // Will eventually be used to strore the score
    @State private var level = "level1"
    
    // Character properties
    @State private var jumpOffset: CGFloat = 0 // New state variable to control the character's jump
    @State private var canJump = true
    
    // Timer properties
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() // Creates timer
    @State private var speedUp = false // Creates timer
    
    var body: some View {
        GeometryReader { geometry in // This geometry reader provides info on the geometry of the photos inside of it. This helps us more easily resize the images
            ZStack {
                // Moving background
                ForEach(0..<2) { index in
                    Image(level)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffset + CGFloat(index) * geometry.size.width, y: 0) // This allows the background to fill the whole screen and allows it to stay fullscreen when the background moves
                } // For loop for the moving background
                
                // Moving object
                Rectangle()
                    .fill(Color.red)
                    .border(Color.black)
                    .frame(width: objWidth, height: objHeight)
                    .position(CGPoint(x: 890.0 + Double((objPosition)), y: 322)) // This is our test rectangle for now that can later be swapped out for obsticals. it moves across the screen and when it exits the left side, another one comes out the right side
                
                // below rectangles were created to test contact detection. Left as comments just in case more testing is needed, if not delete below comments.
               // Rectangle()
                    // .fill(Color.yellow)
                //.frame(width: 1, height: 77)
                    //.position(CGPoint(x: 117.0 + (objWidth / 2), y: 307.0 + jumpOffset))
                // Rectangle()
                //   .fill(Color.yellow)
                // .frame(width: 1, height: 77)
                //  .position(CGPoint(x: 138 - (objWidth / 2), y: 307.0 + jumpOffset))
                // Rectangle()
                //  .fill(Color.yellow)
                //  .frame(width: 90, height: 1)
                //  .position(CGPoint(x: 128.0, y: 347.0 + jumpOffset))
                //  Rectangle()
                //  .fill(Color.yellow)
                //   .frame(width: 1, height: 77)
                //  .position(CGPoint(x: 150, y: 307.0))

    

                // Character

                Image("Character") // May be changed in final game
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3) // This adjusts how far left or right the character is
                    .offset(x: -geometry.size.width * 0.35, y: geometry.size.height * 0.29 + jumpOffset) // This adjusts the height of the character
                    .gesture(
                        TapGesture().onEnded {
                            if canJump == true {
                                jump()
                            }
                        } // When the character is tapped, it calls the jump function whih allows the character to jump
                    )
            }
            VStack{
                var Num = String(Int(score))
                CustomText(text: "Score: " +  Num).foregroundColor(.brown)
            }
            
            .onReceive(timer) { _ in
                xOffset -= 2 // Every time the timer ticks, it moves the background over towards the left, creating the effect that its moving
                objPosition -= 4 // Moves object to the left every time the timer ticks
                checkXContact()
     
                // Reset object position if it goes off the screen
                if objPosition <= -925 {
                    objPosition = 0
                    setObject()
                }
                
                // Reset background position if it goes off the screen
                if xOffset <= -geometry.size.width {
                    xOffset = 0
                }
                
                // Increase score
                score += 0.05
                
                if score >= 100 && score < 200 {
                    level = "level2"
                    gameSpeedChange1() //updates game speed
                }
                else if score >= 200  {
                    level = "level3"
                    gameSpeedChange2() //updates game speed
                }
            }
            .clipped()
        }
        .edgesIgnoringSafeArea(.all) // Makes it full screen
    }
    
    func resetGame() {
        score = 0
        objPosition = 0
        objWidth = 50
        objHeight = 50
        level = "level1"
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    
    func checkYContact() {
        if (322 + (objHeight / 2)) == (322 + (objHeight / 2)) + jumpOffset { // checks if bottom of character touches bottom of object
            resetGame()
        }
        else if (322 - (objHeight / 2)) == 297 + jumpOffset { // checks if bottom of character touches top of object
            resetGame()
        }
    }
    
    func checkXContact() {
        disableJump()
           if (890 + objPosition) + (objWidth / 2) == 117 + (objWidth / 2) { // checks if backside of object touches front of character
               checkYContact()
           }
           if (890 + objPosition) + (objWidth / 2) == 138 - (objWidth / 2) { // checks if backside of object touches backside of character
               checkYContact()
           }
           if (890 + objPosition) - (objWidth / 2) == 117 + (objWidth / 2) { // checks if frontside of object touches front of character
               checkYContact()
           }
           if (890 + objPosition) - (objWidth / 2) == 138 - (objWidth / 2) { // checks if front of object touches back of character
               checkYContact()
           }
       }
    
    func disableJump() {
        if Double(objPosition) <= -710 {
            canJump = false
        }
        else {
            canJump = true
        }
    }
    
    func setObject() {
        objWidth = Double.random(in: 25...100)
        objHeight = Double.random(in: 25...100)
    }
    
    func jump() {
        withAnimation(.easeInOut(duration: 0.3)) { // Animation allows the character to smoothly jump on the screen
            jumpOffset = -175 // How high the character jumps
        }
        // Dispatch queue is used to allow the jump to happen at the time of the click and finish executing 0.35 seconds after
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { // How long the character is delayed in the air for.
            withAnimation(.easeInOut(duration: 0.75)) { //how fast the character comes down
                jumpOffset = 0
            }
        }
    }
    
    func gameSpeedChange1() {
        // Update the timer to tick faster
        self.timer = Timer.publish(every: 0.0065, on: .main, in: .common).autoconnect()
    }
    func gameSpeedChange2() {
        // Update the timer to tick faster
        self.timer = Timer.publish(every: 0.005, on: .main, in: .common).autoconnect()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovingBackground()
    }
}
