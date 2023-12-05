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
        Pie(endAngle: .degrees(180))
            .opacity(0.4)
            .overlay(
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1,contentMode: .fit)
                    .padding(5)
            )
            .padding(5)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
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
