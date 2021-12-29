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
        print("deck")
        print(deck)
        deck = Array(deck[numberOfCardsToDeal...])
        onTableCards = Array(deck[..<numberOfCardsToDeal])
        print(deck)
    }
    
    func choose(_ card: Card) {
        
    }
    
    init(cardsSet: Array<Card>) {
        //print(cardsSet)
        cards = cardsSet.shuffled()
        //print(cards)
        deck = cards
        //print(deck)
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
