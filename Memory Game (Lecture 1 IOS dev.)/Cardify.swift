//
//  Cardify.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Радомир Радомир on 12/4/23.
//

import SwiftUI

struct Cardify: ViewModifier{
    let isFaceUp: Bool 
    
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

    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
