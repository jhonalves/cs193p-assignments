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
    
    func deal(numberOfCardsToDeal: Int) {
        model.deal(numberOfCardsToDeal: numberOfCardsToDeal)
    }
    
    func newGame(numberOfCardsToDeal: Int = 12) {
        model.newGame(cardsSet: SoloSetGame.getCardsSet(), numberOfCardsToDeal: numberOfCardsToDeal)
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
    
    func diselect(_ card: Card) {
        model.diselect(card)
    }
}
