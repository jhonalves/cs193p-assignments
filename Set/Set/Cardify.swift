//
//  Cardify.swift
//  Set
//
//  Created by Jhonatan Alves on 06/01/22.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    let game: SoloSetGame
    let card: SoloSetGame.Card
    let selected: Bool
    let matchOnTable: Bool
    let noMatchOnTable: Bool
    
    init(game: SoloSetGame, card: SoloSetGame.Card, selected: Bool, matchOnTable: Bool, noMatchOnTable: Bool) {
        rotation = ((game.deck.first { $0.id == card.id }) != nil) ? 0 : 180
        
        self.game = game
        self.card = card
        self.selected = selected
        self.matchOnTable = matchOnTable
        self.noMatchOnTable = noMatchOnTable
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            shape
                .fill()
                .foregroundColor(.white)
            if matchOnTable {
                shape
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.green)
            } else if noMatchOnTable {
                shape
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.red)
            } else if !selected {
                shape
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.black)
            } else {
                shape
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.blue)
            }
            if rotation < 90 {
                Text("👾")
            } else {
                content
            }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants{
        static var cornerRadius: CGFloat = 10
        static var lineWidth: CGFloat = 4
    }
}

extension View {
    func cardify(game: SoloSetGame, card: SoloSetGame.Card, selected: Bool, matchOnTable: Bool, noMatchOnTable: Bool) -> some View {
        self.modifier(Cardify(game: game,
                              card: card,
                              selected: selected,
                              matchOnTable: matchOnTable,
                              noMatchOnTable: noMatchOnTable))
    }
}
