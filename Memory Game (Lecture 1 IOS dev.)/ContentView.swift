//
//  ContentView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var emojisHalloween: Array<String> = ["👻","😈","🕷️","🎃","🕸️","🩸","💀","🍭","👻","😈","🕷️","🎃","🕸️","🩸","💀","🍭"].shuffled()
    @State var emojisNewYears: Array<String> = ["🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁","🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁"].shuffled()
    @State var emojisSports: Array<String> = ["⚽️","🏀","🏈","⚾️","🎾","🎱","⚽️","🏀","🏈","⚾️","🎾","🎱"]
        .shuffled()
    
    @State var currentTheme:String = "S"
    @State var cardCount: Int = 16
    
    var body: some View {
        appName
        Spacer()
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            VStack{
//              cardCountAdjusters
                themes
                shuffleButton
            }
            
        }.padding()
    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset},
//                label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset > 16 || cardCount + offset < 0)
//        .font(.largeTitle)
//        .imageScale(.large)
//    }
    
//    var cardCountAdjusters: some View{
//        VStack{
//            cardAdder
//            cardRemover
//        }
//    }
    var themes: some View{
        HStack{
            sportsTheme
            halloweenTheme
            newYearsTheme
        }
    }
    var appName: some View {
        VStack{
            if currentTheme == "H" {
                Text("Memorize").font(.title).fontDesign(.rounded).foregroundColor(.orange)
            }
            else if currentTheme == "NY" {
                Text("Memorize").font(.title).fontDesign(.rounded).foregroundColor(.red)
            }
            else if currentTheme == "S" {
                Text("Memorize").font(.title).fontDesign(.rounded).foregroundColor(.green)
            }
        }
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(),GridItem(),GridItem(),GridItem()]){
            if currentTheme == "NY" {ForEach(0..<emojisNewYears.count, id: \.self) {index in
                CardView(content: emojisNewYears[index])
                    .aspectRatio(8/10, contentMode:  .fit)
            }
            .foregroundColor(.red)
            }
            else if currentTheme == "H" {ForEach(0..<emojisHalloween.count, id: \.self) {index in
                CardView(content: emojisHalloween[index])
                    .aspectRatio(8/10, contentMode:  .fit)
            }
            .foregroundColor(.orange)
            }
            else if currentTheme == "S" {
                ForEach(0..<emojisSports.count, id: \.self) {index in
                CardView(content: emojisSports[index])
                    .aspectRatio(7/10, contentMode:  .fit)
            }
            .foregroundColor(.green)
            }
        }
    }
//    var cardAdder: some View {
//        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus")
//        .padding()
//    }
//    var cardRemover: some View{
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
//    }
    var halloweenTheme: some View {
        Button(action: {
            currentTheme = "H"
        }, label: {
            VStack{
                Text("Halloween")
                Image(systemName: "balloon").font(.largeTitle)
            }})
        .foregroundColor(.orange)
        .padding()
    }
    var newYearsTheme: some View {
        Button(action: {
            currentTheme = "NY"
        }, label: {
            VStack{
                Text("New Years")
                Image(systemName: "party.popper").font(.largeTitle)}
        })
        .foregroundColor(.red)
        .padding()
        }
    var sportsTheme: some View {
        Button(action:{
            currentTheme = "S"
        }, label: {VStack{
            Text("Sports")
            Image(systemName: "figure.run.circle").font(.largeTitle)}})
        .foregroundColor(.green)
        .padding()
    }
    var shuffleButton: some View {
        Button(action: {
            if currentTheme == "H"{
                emojisHalloween.shuffle()
            }
            else if currentTheme == "NY" {
                emojisNewYears.shuffle()
            }
            else if currentTheme == "S" {
                emojisSports.shuffle()
            }
        }, label: {Text("Shuffle")})
        .padding()
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
                    
            
        }
        .onTapGesture {
            isFaceUp.toggle()
            
        }
    }
    }







#Preview {
    ContentView()
}
