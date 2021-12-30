//
//  SetGame.swift
//  Set
//
//  Created by Jhonatan Alves on 28/12/21.
//

import Foundation

struct SetGame<CardColor, CardShape, CardNumber, CardShading> where CardColor: Equatable, CardShape: Equatable, CardNumber: Equatable, CardShading: Equatable {
    private(set) var cards: Array<Card>
    private(set) var deck: Array<Card>
    private(set) var onTableCards: Array<Card>
    private(set) var matchedCards: Array<Card>
    private(set) var selectedCards: Array<Card>
    var score: Int = 0
    var matchOnTable: Bool = false
    
    mutating func deal(numberOfCardsToDeal: Int) {
        var newDeck: Array<Card>
        var newOnTable: Array<Card>
        
        if deck.count >= numberOfCardsToDeal {
            newDeck = Array(deck[numberOfCardsToDeal...])
            newOnTable = Array(deck[..<numberOfCardsToDeal])
            deck = newDeck
            onTableCards.append(contentsOf: newOnTable)
        } else {
            newDeck = []
            newOnTable = deck
            deck = newDeck
            onTableCards.append(contentsOf: newOnTable)
        }
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
    
    mutating func select(_ card: Card) {
        if !matchOnTable {
            selectedCards.append(card)
            if selectedCards.count > 2 {
                if checkMatch() {
                    score += 1
                    matchOnTable = true
                    matchedCards.append(contentsOf: selectedCards)
                }
                else {
                    if score > 0 {
                        score -= 1
                    }
                }
            }
        } else {
            print("***")
            onTableCards = onTableCards.filter { $0.id != selectedCards[0].id }
            onTableCards = onTableCards.filter { $0.id != selectedCards[1].id }
            onTableCards = onTableCards.filter { $0.id != selectedCards[2].id }
            selectedCards = [card]
            matchOnTable = false
            deal(numberOfCardsToDeal: 3)
        }
    }
    
    mutating func diselect(_ card: Card) {
        if !matchOnTable {
            selectedCards = selectedCards.filter { $0.id != card.id }
        } else {
            print("---")
            onTableCards = onTableCards.filter { $0.id != selectedCards[0].id }
            onTableCards = onTableCards.filter { $0.id != selectedCards[1].id }
            onTableCards = onTableCards.filter { $0.id != selectedCards[2].id }
            selectedCards = []
            matchOnTable = false
            deal(numberOfCardsToDeal: 3)
        }
    }
    
    mutating func checkMatch() -> Bool {
        if (selectedCards[0].color == selectedCards[1].color &&
            selectedCards[1].color == selectedCards[2].color) {
            print(selectedCards[0].color, selectedCards[1].color, selectedCards[2].color)
            //pass
        } else if (selectedCards[0].color != selectedCards[1].color &&
                   selectedCards[1].color != selectedCards[2].color &&
                   selectedCards[0].color != selectedCards[2].color ) {
            print(selectedCards[0].color, selectedCards[1].color, selectedCards[2].color)
        } else {
            return false
        }
        
        if (selectedCards[0].shape == selectedCards[1].shape &&
            selectedCards[1].shape == selectedCards[2].shape) {
            print(selectedCards[0].shape, selectedCards[1].shape, selectedCards[2].shape)
            //pass
        } else if (selectedCards[0].shape != selectedCards[1].shape &&
                   selectedCards[1].shape != selectedCards[2].shape &&
                   selectedCards[0].shape != selectedCards[2].shape ) {
            print(selectedCards[0].shape, selectedCards[1].shape, selectedCards[2].shape)
        } else {
            return false
        }
        
        if (selectedCards[0].number == selectedCards[1].number && selectedCards[1].number == selectedCards[2].number) {
            print(selectedCards[0].number, selectedCards[1].number, selectedCards[2].number)
            //pass
        } else if (selectedCards[0].number != selectedCards[1].number &&
                   selectedCards[1].number != selectedCards[2].number &&
                   selectedCards[0].number != selectedCards[2].number ) {
            print(selectedCards[0].number, selectedCards[1].number, selectedCards[2].number)
        } else {
            return false
        }
        
        if (selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading) {
            print(selectedCards[0].shading, selectedCards[1].shading, selectedCards[2].shading)
            //pass
        } else if (selectedCards[0].shading != selectedCards[1].shading &&
                   selectedCards[1].shading != selectedCards[2].shading &&
                   selectedCards[0].shading != selectedCards[2].shading ) {
            print(selectedCards[0].shading, selectedCards[1].shading, selectedCards[2].shading)
        } else {
            return false
        }
        
        return true
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
