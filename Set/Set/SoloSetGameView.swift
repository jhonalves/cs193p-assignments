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
            HStack {
                Text("Set Game").font(.largeTitle)
                Spacer()
                VStack {
                    Text("Score").font(.title)
                    Text(String(game.score)).font(.largeTitle)
                }
            }
            .padding()
            AspectVGrid(items: game.onTableCards, aspectRatio: 2/3) { card in
                if ((game.selectedCards.first { $0.id == card.id }) == nil) {
                    CardView(card: card, selected: false, matchOnTable: false, noMatchOnTable: false)
                        .padding(6.0)
                        .onTapGesture {
                            if game.selectedCards.count < 3 || game.matchOnTable {
                                game.select(card)
                            }
                        }
                } else {
                    CardView(card: card, selected: true, matchOnTable: game.matchOnTable, noMatchOnTable: game.noMatchOnTable)
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
    let matchOnTable: Bool
    let noMatchOnTable: Bool
    
    @ViewBuilder var body: some View {
        let shape = RoundedRectangle(cornerRadius: 10)
        
        ZStack {
            shape
                .fill()
                .foregroundColor(.white)
            if matchOnTable {
                shape.strokeBorder(lineWidth: 6)
                    .foregroundColor(.green)
            } else if noMatchOnTable {
                shape.strokeBorder(lineWidth: 6)
                    .foregroundColor(.red)
            } else if !selected {
                shape.strokeBorder(lineWidth: 4)
                    .foregroundColor(.black)
            } else {
                shape.strokeBorder(lineWidth: 4)
                    .foregroundColor(.blue)
            }
            VStack {
                cardContent()
                    .foregroundColor(cardColor(card: card))
            }
            .padding(10)
        }
    }
    
    private func cardContent() -> some View {
        ForEach(0..<card.number.rawValue, id: \.self) {_ in
            cardShape()
                .frame(height: 20)
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
    
    @ViewBuilder
    private func cardShape() -> some View {
        switch card.shape {
        case .diamond:
            switch card.shading {
            case .solid:
                Diamond()
                    .fill()
            case .striped:
                Diamond()
                    .opacity(0.4)
            case .open:
                Diamond()
                    .stroke(lineWidth: 3)
            }
        case .rectangle:
            switch card.shading {
            case .solid:
                Rectangle()
                    .fill()
            case .striped:
                Rectangle()
                    .opacity(0.4)
            case .open:
                Rectangle()
                    .stroke(lineWidth: 3)
            }
        case .oval:
            switch card.shading {
            case .solid:
                Capsule()
                    .fill()
            case .striped:
                Capsule()
                    .opacity(0.4)
            case .open:
                Capsule()
                    .stroke(lineWidth: 3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SoloSetGameView(game: game)
    }
}
