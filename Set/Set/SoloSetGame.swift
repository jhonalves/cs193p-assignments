//
//  SoloSetGame.swift
//  Set
//
//  Created by Jhonatan Alves on 28/12/21.
//

import SwiftUI

class SoloSetGame: ObservableObject {
    typealias Card = SetGame<cardColor, cardShape, CardNumber, cardShading>.Card
    
    init() {
        newGame()
    }
    
    private static func getCardsSet() -> Array<Card> {
        var cardsSet: Array<Card> = []
        var cardID = 0
        
        for color in cardColor.allCases {
            for shape in cardShape.allCases {
                for number in CardNumber.allCases {
                    for shading in cardShading.allCases {
                        cardsSet.append(Card.init(color: color, shape: shape, number: number, shading: shading, id: cardID))
                        cardID += 1
                    }
                }
            }
        }
        
        return cardsSet
    }
    
    private static func createCardsSet() -> SetGame<cardColor, cardShape, CardNumber, cardShading> {
        let cardsSet = getCardsSet()
        
        return SetGame<cardColor, cardShape, CardNumber, cardShading>(cardsSet: cardsSet)
    }
    
    @Published private var model = createCardsSet()
    
    var cards: Array<Card> {
        model.cards
    }
    var deck: Array<Card> {
        model.deck
    }
    var onTableCards: Array<Card> {
        model.onTableCards
    }
    var matchedCards: Array<Card> {
        model.matchedCards
    }
    var selectedCards: Array<Card> {
        model.selectedCards
    }
    var score: Int {
        model.score
    }
    var matchOnTable: Bool {
        model.matchOnTable
    }
    var noMatchOnTable: Bool {
        model.noMatchOnTable
    }
    var endGame: Bool {
        model.endGame
    }
    var onTableCombinations: Bool {
        model.onTableCombinations
    }
    
    func getCardColor(card: SoloSetGame.Card) -> Color {
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
    func getCardShape(card: Card) -> some View {
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
    
    enum cardColor: CaseIterable {
        case green
        case red
        case purple
    }
    enum cardShape: CaseIterable {
        case diamond
        case rectangle
        case oval
    }
    enum CardNumber: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    enum cardShading: CaseIterable {
        case solid
        case striped
        case open
    }
    
    // MARK: - Intent(s)
    
    func select(_ card: Card) {
        model.select(card)
    }
    
    func deselect(_ card: Card) {
        model.deselect(card)
    }
    
    func deal(numberOfCardsToDeal: Int) {
        model.deal(numberOfCardsToDeal: numberOfCardsToDeal)
    }
    
    func newGame(numberOfCardsToDeal: Int = 21) {
        model.newGame(cardsSet: SoloSetGame.getCardsSet(), numberOfCardsToDeal: numberOfCardsToDeal)
    }
}
