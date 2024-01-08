//
//  MemorizeGame.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 23.10.2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var score = 0
    
    init(numberOfPairsOfCards:Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{ cards.indices.filter{index in cards[index].isFaceUp}.only}
        set {cards.indices.forEach{cards[$0].isFaceUp = (newValue == $0)}}
    }
        
    mutating func choose(_ card:Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen{
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    

    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
                     
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        
//        private mutating func startUsingBonusTime () {
//            if isFaceUp && isMatched && bonusTimeRemaining > 0 , lasftFaceUpdate == nil {
//                lastFaceUpdate = Date()
//            }
//        }
//        
//        private mutating func stopUsingBonusTime () {
//            pastFaceUpTime = faceUpTime
//            lastFaceUpDate = nil
//        }
//        
//        var bonus: Int {
//            Int(bonusTimeLimit * bonusPercentRemaining)
//        }
//        
//        var bonusPercentRemaining: Double {
//            bonusTimeLimit > 0 ? max(0 - bonusTimeLimit-faceTimeUp)/bonusTimeLimit : 0
//        }
//        
//        var faceUpTime: TimeInterval {
//            if let lastFaceUp
//        }
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "Matched" : "")"
        }
    }
}

extension  Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
