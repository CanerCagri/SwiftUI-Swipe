//
//  ContentView.swift
//  SwiftUI-Swipe
//
//  Created by Caner Çağrı on 11.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CardView(card: CardModel(name: "Caner", age: 26, image: "user1"))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    
    var card: CardModel
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Image(card.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75, alignment: .center)
                    .clipped()
                
                Text(card.description)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
        }
    }
}
