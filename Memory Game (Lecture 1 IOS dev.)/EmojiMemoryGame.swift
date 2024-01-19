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
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if emojisHalloween.indices.contains(pairIndex) {
                return emojisHalloween[pairIndex] 
            } else {
                return "❌"
            }
        } 
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    
    var score: Int {
        model.score
    }
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func restartGame() ->MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if EmojiMemoryGame.emojisHalloween.indices.contains(pairIndex) {
                return EmojiMemoryGame.emojisHalloween[pairIndex] //closure above ^
            } else {
                return "❌"
            }
        }
    }
    
    func restart() {
        model.restart()
    }
}
