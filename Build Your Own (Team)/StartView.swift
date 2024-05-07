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
            ZStack {
                Image("level1")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    
                VStack {
                    CustomText(text: "Title (TBD)")
                        .padding(68)
                    NavigationLink("START GAME", destination: MovingBackground())
                        .background(Rectangle().frame(width: 150.0, height: 50.0) .foregroundColor(.yellow).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2.5))
                        .position(CGPoint(x: 570.0, y: -62.0))
                    .padding(79)
                }
                Image("Monkey").resizable().frame(width: 300, height: 250, alignment: .topLeading).position(CGPoint(x: 370.0, y: 250.0))
                NavigationLink("SELECT CHARACTER", destination: SelectView()).navigationBarBackButtonHidden(true)
                .background(Rectangle().frame(width: 200.0, height: 50.0) .foregroundColor(.yellow).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2.5))
                .position(CGPoint(x: 100.0, y: 250.0))
            }
        }
    }
}
#Preview {
    StartView()
}
struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Futura-Bold", size: 70))
    }
}
struct CustomLink: View {
    let link: String
    var body: some View {
        Text(link).font(Font.custom("", size: 40)).fontWeight(.heavy).foregroundColor(Color.black)
    }
}
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 50)
            .font(Font.custom("Marker Felt", size: 24))
            .padding()
            .background(.red).opacity(configuration.isPressed ? 0.0 : 1.0)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
