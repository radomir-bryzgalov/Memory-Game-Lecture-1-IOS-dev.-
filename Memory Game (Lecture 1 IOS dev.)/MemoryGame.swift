//
//  MemorizeGame.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 23.10.2023.
//

import Foundation

struct MemoryGame<CardContent>{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards:Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
        
    func choose(_ card:Card){
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
                     
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}

