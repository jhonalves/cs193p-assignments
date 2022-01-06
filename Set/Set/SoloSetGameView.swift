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
                        withAnimation {
                            Text(String(game.score)).font(.largeTitle)
                        }
                    }
                }
                if game.endGame {Text("No more combinations")}
            }
            .padding()
            if game.onTableCombinations { cards } else { cards.opacity(gameConstants.disabledOpacity) }
            Spacer()
            HStack {
                newGameButton.font(.largeTitle).padding()
                Spacer()
                if !game.deck.isEmpty {
                    dealButton.font(.largeTitle).padding()
                } else {
                    dealButton.font(.largeTitle).padding().disabled(true)
                }
            }
        }
    }
    
    var cards: some View {
        AspectVGrid(items: game.onTableCards, aspectRatio: gameConstants.cardsAspectRatio) { card in
            if ((game.selectedCards.first { $0.id == card.id }) == nil) {
                CardView(game: game, card: card, selected: false, matchOnTable: false, noMatchOnTable: false)
                    .padding(6.0)
                    .onTapGesture {
                        if game.selectedCards.count < gameConstants.maxCards || game.matchOnTable && !game.endGame {
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
        Button("New Game") {
            game.newGame()
        }
    }
    
    var dealButton: some View {
        Button ("Deal") {
            withAnimation(.easeInOut) {
                game.deal(numberOfCardsToDeal: gameConstants.dealQuantity)
            }
        }
    }
    
    private struct gameConstants {
        static let disabledOpacity = 0.5
        static let maxCards = 3
        static let cardsAspectRatio: Double = 2/3
        static let dealQuantity = 3
    }
}

struct CardView: View {
    let game: SoloSetGame
    let card: SoloSetGame.Card
    let selected: Bool
    let matchOnTable: Bool
    let noMatchOnTable: Bool
    
    @ViewBuilder var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape
                    .fill()
                    .foregroundColor(.white)
                if matchOnTable {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(.green)
                } else if noMatchOnTable {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(.red)
                } else if !selected {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(.black)
                } else {
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        .foregroundColor(.blue)
                }
                VStack {
                    cardContent(height: geometry.size.height)
                        .foregroundColor(game.getCardColor(card: card))
                }
                .padding(10)
            }
        }
    }
    
    private func cardContent(height: CGFloat) -> some View {
        ForEach(0..<card.number.rawValue, id: \.self) {_ in
            game.getCardShape(card: card)
                .frame(maxHeight: height / 6 )
        }
    }
    
    private struct DrawingConstants{
        static var cornerRadius: CGFloat = 10
        static var lineWidth: CGFloat = 4
        static var fontScale: CGFloat = 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SoloSetGameView(game: game)
    }
}
