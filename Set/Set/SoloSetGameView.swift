//
//  SoloSetGameView.swift
//  Set
//
//  Created by Jhonatan Alves on 22/12/21.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGame
    
    var body: some View {
        VStack {
            AspectVGrid(items: game.onTableCards, aspectRatio: 2/3) { card in
                CardView(card: card)
            }
            Spacer()
            HStack {
                Button (action: {
                    game.newGame()
                }, label: {
                    Text("New Game").font(.largeTitle)
                })
                .padding()
                Spacer()
                Button (action: {
                    game.deal(numberOfCardsToDeal: 3)
                }, label: {
                    Text("Deal").font(.largeTitle)
                })
                .padding()
            }
        }
    }
}

struct CardView: View {
    let card: SoloSetGame.Card
    
    @ViewBuilder var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        
        ZStack {
            shape
                .fill()
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 4)
            VStack {
                ForEach(0..<card.number.rawValue) {_ in
                    switch card.shape {
                    case .diamond:
                        Ellipse()
                            .padding()
                    case .rectangle:
                        Rectangle()
                            .padding()
                    case .oval:
                        Capsule()
                            .padding()
                    }
                }
                .foregroundColor(cardColor(card: card))
            }
        }
        .foregroundColor(.red)
    }
    
    private func cardColor(card: SoloSetGame.Card) -> Color {
        switch card.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
    
    private func cardShape(card: SoloSetGame.Card) -> String {
        switch card.shape {
        case .diamond:
            return "a"
        case .rectangle:
            return "b"
        case .oval:
            return "c"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SoloSetGameView(game: game)
    }
}
