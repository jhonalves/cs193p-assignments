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
    var noMatchOnTable: Bool = false
    
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
    
    mutating func replaceCard(cardPosition: Int) {
        var cardIndex: Int
        cardIndex = onTableCards.firstIndex { $0.id == selectedCards[cardPosition].id } ?? onTableCards.count + 1
        onTableCards = onTableCards.filter { $0.id != selectedCards[cardPosition].id }
        if deck.count > 0 {
            onTableCards.insert(deck[0], at: cardIndex )
            deck.remove(at: 0)
        }
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
                    noMatchOnTable = true
                    if score > 0 {
                        score -= 1
                    }
                }
            }
        } else {
            replaceCard(cardPosition: 0)
            replaceCard(cardPosition: 1)
            replaceCard(cardPosition: 2)
            selectedCards = [card]
            matchOnTable = false
            noMatchOnTable = false
        }
    }
    
    mutating func diselect(_ card: Card) {
        if !matchOnTable {
            selectedCards = selectedCards.filter { $0.id != card.id }
            noMatchOnTable = false
        } else {
            replaceCard(cardPosition: 0)
            replaceCard(cardPosition: 1)
            replaceCard(cardPosition: 2)
            selectedCards = []
            matchOnTable = false
            noMatchOnTable = false
        }
    }
    
    func countEquals<T: Equatable>(firstCard: T, secondCard: T, thirdCard: T) -> Bool {
        if (firstCard == secondCard &&
            secondCard == thirdCard) {
            // check if all 3 are equal
        } else if (firstCard != secondCard &&
                   secondCard != thirdCard &&
                   firstCard != thirdCard ) {
            // check if all 3 are different
        } else {
            // non matching cards
            return false
        }
        
        // matching cards
        return true
    }
    
    mutating func checkMatch() -> Bool {
        var match:Bool
        
        match = countEquals(firstCard: selectedCards[0].color,
                    secondCard: selectedCards[1].color,
                    thirdCard: selectedCards[2].color)
        
        if match { match = countEquals(firstCard: selectedCards[0].shape,
                                       secondCard: selectedCards[1].shape,
                                       thirdCard: selectedCards[2].shape)}
        
        if match { match = countEquals(firstCard: selectedCards[0].number,
                                       secondCard: selectedCards[1].number,
                                       thirdCard: selectedCards[2].number)}
        
        if match { match = countEquals(firstCard: selectedCards[0].shading,
                                       secondCard: selectedCards[1].shading,
                                       thirdCard: selectedCards[2].shading)}
        
        return match
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
