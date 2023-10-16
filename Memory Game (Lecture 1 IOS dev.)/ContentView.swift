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
    
    @State var currentEmojisList: Array<String> = [""]
    @State var currentTheme:String = "H"
    @State var cardCount: Int = 16
    
    var body: some View {
        appName
        Spacer()
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            HStack{
                cardCountAdjusters
                themes
                flipCardsButton
            }
            
        }.padding()
    }
//    func currentCardCount(theme: String) -> int{
//        if theme == "H"{
//            return emojisHalloween.count()
//        }
//        else if theme == "NY" {
//            return emojisNewYears.count()
//        }
//        else if theme == "S" {
//            return emojisSports.count()
//        }
//    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button( action: {
            cardCount += offset},
                label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset > emojisSports.count || cardCount + offset < 0)
        .font(.largeTitle)
        .imageScale(.large)
    }
    
    var cardCountAdjusters: some View{
        VStack{
            cardAdder
            cardRemover
        }
    }
    var themes: some View{
        VStack{
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
                    .aspectRatio(7/10, contentMode:  .fit)
            }
            .foregroundColor(.red)
            }
            else if currentTheme == "H" {ForEach(0..<emojisHalloween.count, id: \.self) {index in
                CardView(content: emojisHalloween[index])
                    .aspectRatio(7/10, contentMode:  .fit)
            }
            .foregroundColor(.orange)
            }
            else if currentTheme == "S" {ForEach(0..<emojisSports.count, id: \.self) {index in
                CardView(content: emojisSports[index])
                    .aspectRatio(7/10, contentMode:  .fit)
            }
            .foregroundColor(.green)
            }
        }
    }
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus")
        .padding()
    }
    var cardRemover: some View{
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
    }
    var halloweenTheme: some View {
        Button("Halloween") {
            currentTheme = "H"
            emojisHalloween.shuffle()
        }
        .foregroundColor(.orange)
        .padding()
    }
    var newYearsTheme: some View {
        Button("New Years") {
            currentTheme = "NY"
            emojisNewYears.shuffle()
        }
        .foregroundColor(.red)
        .padding()
    }
    var sportsTheme: some View {
        Button("Sports"){
            currentTheme = "S"
            emojisSports.shuffle()
        }
        .foregroundColor(.green)
        .padding()
    }
    var flipCardsButton: some View {
        Button(action: {},
               label:{Text("Flip")})
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
