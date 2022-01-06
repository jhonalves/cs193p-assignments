//
//  SoloSetGameView.swift
//  Set
//
//  Created by Jhonatan Alves on 22/12/21.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            top.padding()
            if game.onTableCombinations { cards } else { cards.opacity(gameConstants.disabledOpacity) }
            bottom
        }
    }
    
    var cards: some View {
        AspectVGrid(items: game.onTableCards, aspectRatio: gameConstants.cardsAspectRatio) { card in
            if ((game.selectedCards.first { $0.id == card.id }) == nil) {
                CardView(game: game, card: card, selected: false, matchOnTable: false, noMatchOnTable: false)
                    .padding(6.0)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .onTapGesture {
                        if game.selectedCards.count < gameConstants.maxCards {
                            game.select(card)
                        } else if game.matchOnTable && !game.endGame {
                            withAnimation {
                                game.select(card)
                            }
                        } else if game.noMatchOnTable && !game.endGame {
                            game.select(card)
                        }
                    }
            } else {
                CardView(game: game, card: card, selected: true, matchOnTable: game.matchOnTable, noMatchOnTable: game.noMatchOnTable)
                    .padding(6.0)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .onTapGesture {
                        if game.matchOnTable && !game.endGame {
                            withAnimation {
                                game.deselect(card)
                            }
                        } else {
                            game.deselect(card)
                        }
                    }
            }
        }
    }
    
    var top: some View {
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
    }
    
    var bottom: some View {
        HStack {
            matchedCards
            Spacer()
            newGameButton.font(.largeTitle).padding()
            Spacer()
            deck
        }.padding(.horizontal)
    }
    
    var newGameButton: some View {
        Button("New Game") {
            withAnimation {
                game.newGame()
            }
        }
    }
    
    var dealButton: some View {
        Button ("Deal") {
            withAnimation(.easeInOut) {
                game.deal(numberOfCardsToDeal: gameConstants.dealQuantity)
            }
        }
    }
    
    private func zIndex(of card: SoloSetGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var deck: some View {
        ZStack {
            ForEach (game.deck) { card in
                CardView(game: game, card: card, selected: false, matchOnTable: false, noMatchOnTable: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: gameConstants.bottomCardsWidth, height: gameConstants.bottomCardsHeight)
        .onTapGesture {
            if !game.deck.isEmpty {
                withAnimation(.easeInOut) {
                    game.deal(numberOfCardsToDeal: gameConstants.dealQuantity)
                }
            }
        }
    }
    
    var matchedCards: some View {
        ZStack {
            ForEach (game.matchedCards) { card in
                CardView(game: game, card: card, selected: false, matchOnTable: false, noMatchOnTable: false)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
            }
        }
        .frame(width: gameConstants.bottomCardsWidth, height: gameConstants.bottomCardsHeight)
    }
    
    private struct gameConstants {
        static let disabledOpacity: Double = 0.5
        static let maxCards: Int = 3
        static let dealQuantity: Int = 3
        static let cardsAspectRatio: CGFloat = 2/3
        static let bottomCardsHeight: CGFloat = 90
        static let bottomCardsWidth: CGFloat = bottomCardsHeight * cardsAspectRatio
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
                VStack {
                    CardContent(card: card,height: geometry.size.height)
                }
                .padding(10)
            }
            .cardify(game: game, card: card, selected: selected, matchOnTable: matchOnTable, noMatchOnTable: noMatchOnTable)
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
