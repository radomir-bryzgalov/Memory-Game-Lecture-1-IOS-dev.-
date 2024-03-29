//
//  EmojiMemoryGameView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel:EmojiMemoryGame
    
    @State var emojisHalloween: Array<String> =  ["👻","😈","🕷️","🎃","🕸️","🩸","💀","🍭"].shuffled()

    @State var emojisNewYears: Array<String> = ["🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁","🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁"].shuffled()
    @State var emojisSports: Array<String> = ["⚽️","🏀","🏈","⚾️","🎾","🎱","⚽️","🏀","🏈","⚾️","🎾","🎱"]
        .shuffled()
    
    @State var currentTheme:String = "NY"
    @State var cardCount: Int = 16
    private let aspectRatio: CGFloat = 4/5
    private let dealAnimation: Animation = .easeInOut(duration: 2)
    private let delayInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    

    var body: some View {
        VStack {
            appName
            cards
            HStack {
                score
                Spacer()
                highestScore
            }
            deck.foregroundColor(.red)
            Spacer()
//            themes
            HStack {
                restartButton
                    .padding()
//                shuffleButton
            }
            
            
        }.padding()
    }
    
    private var score: some View {
        HStack {
            Text("Score \(viewModel.score)")
                .animation(nil)
        }
    }
    
    private var highestScore: some View {
        Text("High Score \(viewModel.highestScore)")
            .animation(nil)
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
                if isDealt(card) {
                    CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamepace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                        .padding(4)
                        .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                        .onTapGesture {
                            choose(card)
                        }
                        .foregroundColor(.red)
                }
            }
        }
        
        else if currentTheme == "S" {
            AspectVGrid(viewModel.cards, aspectRatio:aspectRatio) {card in
                if isDealt(card){
                    CardView(card)
                        .padding(4)
                        .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                        .onTapGesture {
                            choose(card)
                        }
                        .foregroundColor(.green)
                        .transition(.offset(
                            x: CGFloat.random(in: -1000...1000),
                            y: CGFloat.random(in: -1000...1000)
                        ))
                }
            }
        }
        else if currentTheme == "H" {
            AspectVGrid(viewModel.cards, aspectRatio:aspectRatio) {card in
                if isDealt(card) {
                    withAnimation {CardView(card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamepace)
                        .padding(4)
                        .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                        .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                        .onTapGesture {
                            choose(card)
                        }
                        .foregroundColor(.orange)
                }
            }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt( _ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter {!isDealt($0)}
    }
    
    @Namespace private var dealingNamepace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) {card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamepace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture{
            deal()
        }
        
    }
    
    private func deal () {
        var delay: TimeInterval = 0
        for card in viewModel.cards{
            withAnimation(dealAnimation.delay(delay)){
               _ = dealt.insert(card.id)
            }
            delay += delayInterval
        }

    }
    
    private func choose ( _ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, card.id)
        }
    }
    
    
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
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
                withAnimation {viewModel.shuffle()
                }
            }
            else if currentTheme == "NY" {
                withAnimation {viewModel.shuffle()
                }           
            }
            else if currentTheme == "S" {
                withAnimation {viewModel.shuffle()
                }
            }
        }, label: {Text("Shuffle")})
        .padding()
    }
    var restartButton: some View {
        Button(action: {viewModel.restart()}, label: {Text("Restart")})
    }
}


struct EmojiMemoryGameView_Previews : PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
