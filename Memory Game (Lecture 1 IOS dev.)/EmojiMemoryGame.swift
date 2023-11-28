//
//  EmojiMemoryGame.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 23.10.2023.
//
//
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojisHalloween = ["👻","😈","🕷️","🎃","🕸️","🩸","💀","🍭"]
       .shuffled()
    
    private static func createMemoryGame() ->MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojisHalloween.indices.contains(pairIndex) {
                return emojisHalloween[pairIndex] //closure above ^
            } else {
                return "❌"
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
