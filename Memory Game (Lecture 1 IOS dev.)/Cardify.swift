//
//  Cardify.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Радомир Радомир on 12/4/23.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable{
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation}
        set { rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
                base.fill(Color.white)
                base.strokeBorder(lineWidth: 2)
                    .background(base.fill(Color.white))
                    .overlay(content)
                    .opacity(isFaceUp ? 1 : 0)
                base.fill()
                    .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0)
        )
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
