//
//  ContentView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻","😈", "🕷️", "🎃","👽","🦊", "🍭", "🕸️", "🩸"]
    
    @State var cardCount: Int = 5
    
    var body: some View {
        HStack {
            VStack {
                ForEach(0..<cardCount, id: \.self) {index in
                    CardView(content: emojis[index])
                }
                .foregroundColor(.orange)
            }
            VStack {
                Button("Add Card") {
                    cardCount+=1
                    
                }
                Spacer()
                Button(action :{
                    cardCount -= 1
                }, label: {
                    Text("Remove Card")
                })
                .padding()
            }
        }
            .padding()
        
    }
    
struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else {
                base
                    
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
            
        }
    }
    }
}






#Preview {
    ContentView()
    
}
