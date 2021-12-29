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
        model.deal(numberOfCardsToDeal: 12)
    }
    
    private static func createCardsSet() -> SetGame<cardColor, cardShape, CardNumber, cardShading> {
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
        case green
        case red
        case purple
    }
}
