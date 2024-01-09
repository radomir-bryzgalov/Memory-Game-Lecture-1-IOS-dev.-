//
//  CardView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Радомир Радомир on 12/4/23.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView (.animation(minimumInterval:1/10)) {timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(0.4)
                    .overlay(cardContents.padding(5))
                    .padding(5)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: 100))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .aspectRatio(1,contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration:1), value: card.isMatched)
    }
}



extension Animation{
    static func spin(duration: TimeInterval) -> Animation{
        .easeInOut(duration: 1)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        HStack{
            CardView(Card(content:"X", id: "test1")).padding().foregroundColor(.blue)
            CardView(Card(isFaceUp: true, content:"This is a very long string AAAA and I hope it fits", id: "test2")).padding().foregroundColor(.blue)

        }
    }
}
