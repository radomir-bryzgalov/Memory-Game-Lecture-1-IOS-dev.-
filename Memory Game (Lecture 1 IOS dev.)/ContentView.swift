//
//  ContentView.swift
//  Memory Game (Lecture 1 IOS dev.)
//
//  Created by Radomir on 05.10.2023.
//

import SwiftUI

struct ContentView: View {
    let emojisHalloween: Array<String> = ["👻","😈","🕷️","🎃","🕸️","🩸","💀","🍭"]
    let emojisNewYears: Array<String> = ["🥶","🎅","⛄️","❄️","🎄","🍊","🦌","🎁"]
    let emojisSports: Array<String> = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱"]
    
    @State var emojis: Array<String> = [""]
    @State var currentTheme:String = "H"
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            if currentTheme == "H" {
                Text("Memorize").font(.title).fontDesign(.rounded).foregroundColor(.orange)
            }
            else if currentTheme == "NY" {
                Text("Memorize").font(.title).fontDesign(.rounded).foregroundColor(.red)
            }
            else if currentTheme == "S" {
                Text("Memorize").font(.title).fontDesign(.rounded).foregroundColor(.gray)
            }
            HStack {
                
                VStack {
                    if currentTheme == "NY" {ForEach(0..<cardCount, id: \.self) {index in
                        CardView(content: emojisNewYears[index])
                    }
                    .foregroundColor(.red)
                    }
                    else if currentTheme == "H" {ForEach(0..<cardCount, id: \.self) {index in
                        CardView(content: emojisHalloween[index])
                    }
                    .foregroundColor(.orange)
                    }
                    else if currentTheme == "S" {ForEach(0..<cardCount, id: \.self) {index in
                        CardView(content: emojisSports[index])
                    }
                    .foregroundColor(.gray)
                    }
                }
                
                VStack {
                    Button("Add Card") {
                        if cardCount<8 {
                            cardCount+=1
                        }
                        else {
                            cardCount=cardCount
                        }
                    }
                    .padding()
                    
                    Button("Remove Card"){
                        if cardCount>0{
                            cardCount -= 1
                        }
                        else{
                            cardCount=cardCount
                        }
                    }
                    Spacer()
                    
                    Button("Halloween Theme") {
                        currentTheme = "H"
                    }
                    .padding()
                    
                    Button("New Years Theme") {
                        currentTheme = "NY"
                    }
                    .padding()
                    
                    Button("Sports Theme"){
                        currentTheme = "S"
                    }
                    .padding()
                }
            }
            .padding()
            
        }
    }
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







#Preview {
    ContentView()
}
