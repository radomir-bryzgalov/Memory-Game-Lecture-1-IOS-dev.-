//
//  ContentView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct ContentView: View {
    let emojisHalloween: Array<String> = ["👻","😈","🕷️","🎃","🕸️","🩸","💀","🍭"]
    let emojisNewYears: Array<String> = ["🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁"]
    let emojisSports: Array<String> = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱"]
    
    @State var emojis: Array<String> = [""]
    @State var currentTheme:String = "H"
    @State var cardCount: Int = 4
    
    var body: some View {
        appName
        Spacer()
        VStack {
            cards
            Spacer()
            HStack{
                cardCountAdjusters
               
                themes
            }
            
        }.padding()
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button( action: {
            cardCount += offset},
                label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset > emojisSports.count || cardCount + offset < 1)
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
            halloweenTheme
            newYearsTheme
            sportsTheme
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
                Text("Memorize").font(.title).fontDesign(.rounded).foregroundColor(.gray)
            }
        }
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]){
            if currentTheme == "NY" {ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojisNewYears[index])
            }
            .foregroundColor(.red)
            }
            else if currentTheme == "H" {ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojisHalloween[index])
            }
            .foregroundColor(.orange)
            }
            else if currentTheme == "S" {ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojisSports[index])
            }
            .foregroundColor(.gray)
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
        Button("Halloween Theme") {
            currentTheme = "H"
        }
        .padding()
    }
    var newYearsTheme: some View {
        Button("New Years Theme") {
            currentTheme = "NY"
        }
        .padding()
    }
    var sportsTheme: some View {
        Button("Sports Theme"){
            currentTheme = "S"
        }
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
