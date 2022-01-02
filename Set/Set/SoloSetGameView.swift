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
            VStack {
                HStack {
                    Text("Set Game").font(.largeTitle)
                    Spacer()
                    VStack {
                        if game.endGame {
                            Text("Final Score").font(.title)
                        } else {
                            Text("Score").font(.title)
                        }
                        Text(String(game.score)).font(.largeTitle)
                    }
                }
                if game.endGame {Text("No more combinations")}
            }
            .padding()
            if game.onTableCombinations { cards } else { cards.opacity(0.5) }
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
    
    var cards: some View {
        AspectVGrid(items: game.onTableCards, aspectRatio: 2/3) { card in
            if ((game.selectedCards.first { $0.id == card.id }) == nil) {
                CardView(game: game, card: card, selected: false, matchOnTable: false, noMatchOnTable: false)
                    .padding(6.0)
                    .onTapGesture {
                        if game.selectedCards.count < 3 || game.matchOnTable && !game.endGame {
                            game.select(card)
                        } else if game.noMatchOnTable && !game.endGame {
                            game.select(card)
                        }
                    }
            } else {
                CardView(game: game, card: card, selected: true, matchOnTable: game.matchOnTable, noMatchOnTable: game.noMatchOnTable)
                    .padding(6.0)
                    .onTapGesture {
                        game.deselect(card)
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
    let game: SoloSetGame
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
                    .foregroundColor(game.getCardColor(card: card))
            }
            .padding(10)
        }
    }
    
    private func cardContent() -> some View {
        ForEach(0..<card.number.rawValue, id: \.self) {_ in
            game.getCardShape(card: card)
                .frame(height: 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SoloSetGameView(game: game)
    }
}
