import SwiftUI

struct MovingBackground: View {
    // Background properties
    @State private var xOffset: CGFloat = 0 // Position of the background that increases every time the timer ticks
    @State private var objPosition = 0.0 // Position of the block that increases every time the timer ticks
    @State private var objWidth = 50.0
    @State private var objHeight = 50.0
    @State private var score = 0.0 // Will eventually be used to strore the score
    @State private var level = "level1"
    
    // Character properties
    @State private var jumpOffset: CGFloat = 0 // New state variable to control the character's jump
    @State private var canJump = true
    
    // Timer properties
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() // Creates timer
    @State private var speedUp = false // Creates timer
    @State private var paused = false
    
    var body: some View {
        NavigationStack {
        GeometryReader { geometry in // This geometry reader provides info on the geometry of the photos inside of it. This helps us more easily resize the images
            ZStack {
                // Moving background
                ForEach(0..<2) { index in
                    Image(level)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffset + CGFloat(index) * geometry.size.width, y: 0) // This allows the background to fill the whole screen and allows it to stay fullscreen when the background moves
                        .navigationBarBackButtonHidden()
                } // For loop for the moving background
                
                // Moving object
                Rectangle()
                    .fill(Color.red)
                    .border(Color.black)
                    .frame(width: objWidth, height: objHeight)
                    .position(CGPoint(x: 890.0 + Double((objPosition)), y: 322)) // This is our rectangle for now that moves across the screen and when it exits the left side, another one comes out the right side
                
                // Character
                
                Image("Monkey") // May be changed in final game
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
                
                // pause button/pause screen
                if paused == false {
                    Button("Pause", action: {
                        paused = true
                        canJump.toggle()
                        pauseGame()
                    })
                    .background(Rectangle().frame(width: 65.0, height: 30.0) .foregroundColor(.yellow).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2.5))
                    .position(CGPoint(x: 750.0, y: 50.0))
                }
                else if paused == true {
                    Rectangle()
                        .fill(Color.black)
                        .opacity(0.7)
                    VStack {
                        CustomText1(text: "Paused")
                        HStack {
                            NavigationLink(destination: StartView(), label: {
                                Text("Home")
                            })
                            .padding()
                            Button("  Unpause") {
                                paused = false
                                pauseGame()
                            }
                        }
                        .buttonStyle(CustomButtonStyle1())
                    }
                }
            }
            
            // score text
            
            VStack {
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
}
    
    func resetGame() {
        score = 0
        objPosition = 0
        objWidth = 50
        objHeight = 50
        level = "level1"
        paused = false
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
        if Double(objPosition) <= -707 { //once rectangle is located at 180, then character can no longer jump, decrease to give longer window to jump, increase to give shorter
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
    
    func pauseGame() {
        if paused == true {
            self.timer = Timer.publish(every: 100.0, on: .main, in: .common).autoconnect() //changes to every 100 seconds something happens
        }
        else if paused == false {
            if level == "level1" {
                self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
            }
            if level == "level2" {
                gameSpeedChange1()
            }
            if level == "level3" {
                gameSpeedChange2()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovingBackground()
    }
}

struct CustomText1: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Futura-Bold", size: 50)).fontWeight(.heavy).foregroundColor(Color.white)
    }
}
struct CustomText2: View { // this will probably become a custom button
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Futura-Bold", size: 25)).fontWeight(.heavy).foregroundColor(Color.white)
    }
}

struct CustomButtonStyle1: ButtonStyle {
    func makeBody (configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150).font(Font.custom("Futura-Bold", size: 25))
            .foregroundColor(.white)
    }
}
