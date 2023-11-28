//
//  EmojiMemoryGameView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel:EmojiMemoryGame
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            if currentTheme == "NY" {ForEach(viewModel.cards.indices, id: \.self) {index in
                CardView(viewModel.cards[index])
                    .aspectRatio(8/10, contentMode:  .fit)
                    .padding(4)
                    
            }
            .foregroundColor(.red)
            }
            else if currentTheme == "H" {ForEach(viewModel.cards.indices, id: \.self) {index in
                CardView(viewModel.cards[index])
                    .aspectRatio(8/10, contentMode:  .fit)
                    .padding(4)
            }
            .foregroundColor(.orange)
            }
            else if currentTheme == "S" {
                ForEach(viewModel.cards.indices, id: \.self) {index in
                CardView(viewModel.cards[index])
                    .aspectRatio(8/10, contentMode:  .fit)
                    .padding(4)
            }
            .foregroundColor(.green)
            }
        }
    }
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
                viewModel.shuffle()
            }
            else if currentTheme == "NY" {
                viewModel.shuffle()
            }
            else if currentTheme == "S" {
                viewModel.shuffle()
            }
        }, label: {Text("Shuffle")})
        .padding()
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            Group{
                base.fill(Color.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1,contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
                    
            
        }
        .onTapGesture {
            //card.isFaceUp.toggle()
            
        }
    }
    }







#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
