import SwiftUI

struct MovingBackground: View {
    @State private var xOffset: CGFloat = 0
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<2) { index in
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: xOffset + CGFloat(index) * geometry.size.width, y: 0)
                }
                
                Image("Tweety") // Put the name of your overlay image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3) // Adjust size as needed
                    .offset(x: -geometry.size.width * 0.35, y: geometry.size.height * 0.23) // Position on the top left
            }
            .onReceive(timer) { _ in
                xOffset -= 1 // Adjust the speed of movement by changing this value
                
                if xOffset <= -geometry.size.width {
                    xOffset = 0
                }
            }
            .clipped()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovingBackground()
    }
}
