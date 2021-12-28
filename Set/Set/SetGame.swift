//
//  SetGame.swift
//  Set
//
//  Created by Jhonatan Alves on 28/12/21.
//

import Foundation

struct SetGame<CardColor, CardShape, CardNumber, CardShading> {
    var cards: Array<Card>
    var selectedCards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(cardsSet: Array<Card>) {
        cards = cardsSet
        selectedCards = []
    }
    
    struct Card: Identifiable {
        var isOnDeck = true
        var isMatched = false
        var color: CardColor
        var shape: CardShape
        var quantity: CardNumber
        var shading: CardShading
        let id: Int
    }
}
