//
//  ContentView.swift
//  SwiftUI-Swipe
//
//  Created by Caner Çağrı on 11.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var list: [CardModel] = [
        CardModel(name: "Caner", age: 26, image: "user1"),
        CardModel(name: "Michael", age: 23, image: "user2"),
        CardModel(name: "Caner", age: 26, image: "user1"),
        CardModel(name: "Michael", age: 23, image: "user2"),
        CardModel(name: "Caner", age: 26, image: "user1"),
        CardModel(name: "Michael", age: 23, image: "user2"),
    ]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    ForEach(list.indices, id: \.self) { index in
                        CardView(card: list[index], onRemove: { removedCard in
                            withAnimation{
                                self.list.removeAll(where: { $0.id == removedCard.id })
                            }
                           
                        })
                            .frame(width: calculateWidth(geomtry: geometry, index: index), height: 450, alignment: .center)
                            .offset(y: self.calculateOffSet(geomtry: geometry, index: index))
                    }
                }
            }

        }
        .padding()
    }
    
    private func calculateOffSet(geomtry: GeometryProxy, index: Int) -> CGFloat {
        let offset = CGFloat(list.count - 1 - index) * 10
        return offset
    }
    
    private func calculateWidth(geomtry: GeometryProxy, index: Int) -> CGFloat {
        let offset = CGFloat(list.count - 1 - index) * 10
        return geomtry.size.width - offset
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    
    var card: CardModel
    
    @State private var translation: CGSize = .zero
    
    private var thresHoldPercentage: CGFloat = 0.5
    private var onRemove: (_ card: CardModel) -> Void
    
    init(card: CardModel, onRemove: @escaping (_: CardModel) -> Void) {
        self.card = card
        self.onRemove = onRemove
    }
    
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
            .offset(x: translation.width)
            .rotationEffect(.degrees(Double(translation.width / geometry.size.width * 25)), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.translation = value.translation
                    })
                    .onEnded({ value in
                        
                        if abs(value.translation.width) > thresHoldPercentage {
                            onRemove(self.card)
                        } else {
                            withAnimation {
                                self.translation = .zero
                            }
                        }
                    })
            )
        }
    }
}
