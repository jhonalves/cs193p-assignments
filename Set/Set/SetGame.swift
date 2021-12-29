//
//  SetGame.swift
//  Set
//
//  Created by Jhonatan Alves on 28/12/21.
//

import Foundation

struct SetGame<CardColor, CardShape, CardNumber, CardShading> {
    private(set) var cards: Array<Card>
    private(set) var deck: Array<Card>
    private(set) var onTableCards: Array<Card>
    private(set) var matchedCards: Array<Card>
    private(set) var selectedCards: Array<Card>
    
    mutating func deal(numberOfCardsToDeal: Int) {
        var newDeck: Array<Card>
        var newOnTable: Array<Card>
        
        newDeck = Array(deck[numberOfCardsToDeal...])
        newOnTable = Array(deck[..<numberOfCardsToDeal])
        onTableCards.append(contentsOf: newOnTable)
        deck = newDeck
    }
    
    mutating func newGame(cardsSet: Array<Card>, numberOfCardsToDeal: Int) {
        var newDeck: Array<Card>
        var newOnTable: Array<Card>
        
        cards = cardsSet.shuffled()
        deck = cards
        onTableCards = []
        matchedCards = []
        selectedCards = []
        
        newDeck = Array(deck[numberOfCardsToDeal...])
        newOnTable = Array(deck[..<numberOfCardsToDeal])
        deck = newDeck
        onTableCards.append(contentsOf: newOnTable)
    }
    
    func choose(_ card: Card) {
        
    }
    
    init(cardsSet: Array<Card>) {
        cards = cardsSet.shuffled()
        deck = cards
        onTableCards = []
        matchedCards = []
        selectedCards = []
    }
    
    struct Card: Identifiable {
        var isOnDeck = true
        var isMatched = false
        var color: CardColor
        var shape: CardShape
        var number: CardNumber
        var shading: CardShading
        let id: Int
    }
}
