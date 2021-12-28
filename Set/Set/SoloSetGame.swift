//
//  SoloSetGame.swift
//  Set
//
//  Created by Jhonatan Alves on 28/12/21.
//

import SwiftUI

class SoloSetGame: ObservableObject {
    typealias Card = SetGame<cardColor, cardShape, CardNumber, cardShading>.Card
    
    @Published private var model = SetGame<cardColor, cardShape, CardNumber, cardShading>(cardsSet: [])
    
    var cards: Array<Card> {
        model.cards
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
