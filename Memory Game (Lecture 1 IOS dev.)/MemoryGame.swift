//
//  MemorizeGame.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 23.10.2023.
//

import Foundation

struct MemoryGame<CardContent>{
    var cards: Array<Card>
    
    func choose(card:Card){
        
    }
    struct Card{
        var isFaceUp:Bool
        var isMatched:Bool
        var content: CardContent
    }
}
