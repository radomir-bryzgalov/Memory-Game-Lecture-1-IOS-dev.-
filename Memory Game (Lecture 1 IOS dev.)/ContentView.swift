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
            CardView()
            CardView()
            CardView()
                
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    
struct CardView: View {
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("🤠").font(.largeTitle)
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
