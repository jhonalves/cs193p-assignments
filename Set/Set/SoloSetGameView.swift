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
                if ((game.selectedCards.first { $0.id == card.id }) == nil) {
                    CardView(card: card, selected: false)
                        .padding(6.0)
                        .onTapGesture {
                            game.select(card)
                        }
                } else {
                    CardView(card: card, selected: true)
                        .padding(6.0)
                        .onTapGesture {
                            game.diselect(card)
                        }
                }
            }
            Spacer()
            HStack {
                newGameButton.padding()
                Spacer()
                if !game.deck.isEmpty {
                    dealButton.padding()
                } else {
                    dealButton.padding().disabled(true)
                }
            }
        }
    }
    
    var newGameButton: some View {
        Button (action: {
            game.newGame()
        }, label: {
            Text("New Game").font(.largeTitle)
        })
    }
    
    var dealButton: some View {
        Button (action: {
            game.deal(numberOfCardsToDeal: 3)
        }, label: {
            Text("Deal").font(.largeTitle)
        })
    }
}

struct CardView: View {
    let card: SoloSetGame.Card
    let selected: Bool
    
    @ViewBuilder var body: some View {
        let shape = RoundedRectangle(cornerRadius: 10)
        
        ZStack {
            if !selected {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape.strokeBorder(lineWidth: 4)
                cardContent
            } else {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape.strokeBorder(lineWidth: 6)
                    .foregroundColor(.blue)
                cardContent
            }
        }
    }
    
    private func cardColor(card: SoloSetGame.Card) -> Color {
        switch card.color {
        case .red:
            return Color.pink
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
    
    var cardContent: some View {
        VStack {
            Text(String(card.id))
            ForEach(0..<card.number.rawValue) {_ in
                switch card.shape {
                case .diamond:
                    Ellipse()
                        .padding(.vertical)
                case .rectangle:
                    Rectangle()
                        .padding(.vertical)
                case .oval:
                    Capsule()
                        .padding(.vertical)
                }
            }
            .foregroundColor(cardColor(card: card))
        }
        .padding(.horizontal, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SoloSetGameView(game: game)
    }
}
