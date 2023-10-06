//
//  ContentView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView(isFaceUp: true)
            CardView()
            CardView()
                
        }
        .padding()
    }
    
    
struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack{
            if isFaceUp{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 3)
                Text("🤠").font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius:10)
                    .fill(.cyan)
            }
        }
    }
    }
}






#Preview {
    ContentView()
    
}
