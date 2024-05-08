import SwiftUI
struct SelectView: View {
    @State private var character = ""
    var body: some View {
        NavigationStack {
            ZStack {
                Image("level1").resizable().ignoresSafeArea()
                VStack {
                    CustomText(text: "Pick your character")
                    Spacer()
                    Image("Shelf").resizable()
                }
                Image("Monkey").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 100.0, y: 155.0))
                NavigationLink("Monkey Boss", destination: StartView().navigationBarBackButtonHidden(true)).position(CGPoint(x: 100.0, y: 250.0)).onTapGesture(perform: {
                    character = "Monkey"
                    
                })
                Image("Warrior").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 250.0, y: 155.0))
                NavigationLink("Warrior", destination: StartView().navigationBarBackButtonHidden(true)).position(CGPoint(x: 250.0, y: 250.0)).onTapGesture(perform: {
                    character = "Warrior"

                })
                Image("Skull Knight").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 400.0, y: 155.0))
                NavigationLink("Skull Knight", destination: StartView().navigationBarBackButtonHidden(true)).position(CGPoint(x: 400.0, y: 250.0)).onTapGesture(perform: {
                    character = "Skull Knight"
                })
                Image("Evil Goblin").resizable().frame(width: 90, height: 110, alignment: .topLeading).position(CGPoint(x: 560.0, y: 155.0))
                NavigationLink("Evil Goblin", destination: StartView().navigationBarBackButtonHidden(true)).position(CGPoint(x: 570.0, y: 250.0)).onTapGesture(perform: {
                    character = "Evil Goblin"
                })
            }
        }
    }
}
#Preview {
    SelectView()
}
