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
    private(set) var score: Int = 0
    private(set) var matchOnTable: Bool = false
    private(set) var noMatchOnTable: Bool = false
    private(set) var endGame: Bool = false
    private(set) var onTableCombinations: Bool = true
    
    mutating func deal(numberOfCardsToDeal: Int) {
        var newDeck: Array<Card>
        var newOnTable: Array<Card>
        
        if !matchOnTable {
            if deck.count >= numberOfCardsToDeal {
                newDeck = Array(deck[numberOfCardsToDeal...])
                newOnTable = Array(deck[..<numberOfCardsToDeal])
            } else {
                newDeck = []
                newOnTable = deck
            }
            deck = newDeck
        } else {
            newOnTable = selectedCards
            replaceCard(cardPosition: 0)
            replaceCard(cardPosition: 1)
            replaceCard(cardPosition: 2)
        }
        
        onTableCards.append(contentsOf: newOnTable)
        checkOnTableCombinations()
        checkEndGame()
    }
    
    mutating func newGame(cardsSet: Array<Card>, numberOfCardsToDeal: Int) {
        cards = cardsSet.shuffled()
        deck = cards
        onTableCards = []
        matchedCards = []
        selectedCards = []
        score = 0
        matchOnTable = false
        noMatchOnTable = false
        
        deal(numberOfCardsToDeal: numberOfCardsToDeal)
    }
    
    private mutating func replaceCard(cardPosition: Int) {
        if let cardIndex = onTableCards.firstIndex(where: { $0.id == selectedCards[cardPosition].id }) {
            onTableCards = onTableCards.filter { $0.id != selectedCards[cardPosition].id }
            if deck.count > 0 {
                onTableCards.insert(deck[0], at: cardIndex)
                deck.remove(at: 0)
            }
        }
    }
    
    private mutating func cleanAfterMatch() {
        matchedCards.append(contentsOf: selectedCards)
        if onTableCards.count <= 14 {
            replaceCard(cardPosition: 0)
            replaceCard(cardPosition: 1)
            replaceCard(cardPosition: 2)
        } else {
            onTableCards = onTableCards.filter { $0.id != selectedCards[0].id }
            onTableCards = onTableCards.filter { $0.id != selectedCards[1].id }
            onTableCards = onTableCards.filter { $0.id != selectedCards[2].id }
        }
    }
    
    mutating func select(_ card: Card) {
        if !matchOnTable && !noMatchOnTable {
            selectedCards.append(card)
            if selectedCards.count > 2 {
                if checkMatch(cardsToCheck: selectedCards, firstCardIndex: 0, secondCardIndex: 1, thirdCardIndex: 2) {
                    score += 3
                    matchOnTable = true
                    //matchedCards.append(contentsOf: selectedCards)
                }
                else {
                    noMatchOnTable = true
                    if score > 0 {
                        score -= 3
                    }
                }
            }
        } else if noMatchOnTable {
            selectedCards = [card]
            matchOnTable = false
            noMatchOnTable = false
        } else {
            cleanAfterMatch()
            selectedCards = [card]
            matchOnTable = false
            noMatchOnTable = false
        }
        checkEndGame()
        checkOnTableCombinations()
    }
    
    mutating func deselect(_ card: Card) {
        if !matchOnTable {
            selectedCards = selectedCards.filter { $0.id != card.id }
            noMatchOnTable = false
        } else {
            cleanAfterMatch()
            selectedCards = []
            matchOnTable = false
            noMatchOnTable = false
        }
        checkEndGame()
        checkOnTableCombinations()
    }
    
    private func countEquals<T: Equatable>(firstCard: T, secondCard: T, thirdCard: T) -> Bool {
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
    
    private mutating func checkMatch(cardsToCheck: Array<Card>, firstCardIndex: Int, secondCardIndex: Int, thirdCardIndex: Int) -> Bool {
        var match:Bool
        
        match = countEquals(firstCard: cardsToCheck[firstCardIndex].color,
                    secondCard: cardsToCheck[secondCardIndex].color,
                    thirdCard: cardsToCheck[thirdCardIndex].color)
        
        if match { match = countEquals(firstCard: cardsToCheck[firstCardIndex].shape,
                                       secondCard: cardsToCheck[secondCardIndex].shape,
                                       thirdCard: cardsToCheck[thirdCardIndex].shape)}
        
        if match { match = countEquals(firstCard: cardsToCheck[firstCardIndex].number,
                                       secondCard: cardsToCheck[secondCardIndex].number,
                                       thirdCard: cardsToCheck[thirdCardIndex].number)}
        
        if match { match = countEquals(firstCard: cardsToCheck[firstCardIndex].shading,
                                       secondCard: cardsToCheck[secondCardIndex].shading,
                                       thirdCard: cardsToCheck[thirdCardIndex].shading)}
        
        return match
    }
    
    private mutating func checkCombinations(cardsToCheck: Array<Card>) -> Bool {
        var match = false
        
        for firstCardIndex in 0..<cardsToCheck.count {
            for secondCardIndex in 0..<cardsToCheck.count {
                for thirdCardIndex in 0..<cardsToCheck.count {
                    if (firstCardIndex != secondCardIndex && secondCardIndex != thirdCardIndex && firstCardIndex != thirdCardIndex && !match) {
                        match = checkMatch(cardsToCheck: cardsToCheck, firstCardIndex: firstCardIndex, secondCardIndex: secondCardIndex, thirdCardIndex: thirdCardIndex)
                    }
                }
            }
        }
        
        return match
    }
    
    private mutating func checkOnTableCombinations() {
        onTableCombinations = checkCombinations(cardsToCheck: onTableCards)
    }
    
    private mutating func checkEndGame() {
        let availablesCards = onTableCards + deck
        
        endGame = !checkCombinations(cardsToCheck: availablesCards)
    }
    
    init(cardsSet: Array<Card>) {
        cards = cardsSet.shuffled()
        deck = cards
        onTableCards = []
        matchedCards = []
        selectedCards = []
    }
    
    struct Card: Identifiable {
        var color: CardColor
        var shape: CardShape
        var number: CardNumber
        var shading: CardShading
        let id: Int
    }
}
