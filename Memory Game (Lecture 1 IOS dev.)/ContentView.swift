//
//  EmojiMemoryGameView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel:EmojiMemoryGame
    
    @State var emojisHalloween: Array<String> = ["👻","😈","🕷️","🎃","🕸️","🩸","💀","🍭"].shuffled()
    @State var emojisNewYears: Array<String> = ["🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁","🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁"].shuffled()
    @State var emojisSports: Array<String> = ["⚽️","🏀","🏈","⚾️","🎾","🎱","⚽️","🏀","🏈","⚾️","🎾","🎱"]
        .shuffled()
    
    @State var currentTheme:String = "S"
    @State var cardCount: Int = 16
    private let aspectRatio: CGFloat = 4/5

    var body: some View {
        VStack {
            appName
            cards.animation(.default, value: viewModel.cards)
            Spacer()
            VStack{
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
    
    @ViewBuilder
    private var cards: some View {
        if currentTheme == "NY" {
            AspectVGrid(viewModel.cards, aspectRatio:aspectRatio) {card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                    .foregroundColor(.red)
            }
        }
        else if currentTheme == "S" {
            AspectVGrid(viewModel.cards, aspectRatio:aspectRatio) {card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                    .foregroundColor(.green)
            }
        }
        else if currentTheme == "H" {
            AspectVGrid(viewModel.cards, aspectRatio:aspectRatio) {card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                    .foregroundColor(.orange)
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

struct EmojiMemoryGameView_Previews : PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
