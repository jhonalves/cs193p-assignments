//
//  SoloSetGameView.swift
//  Set
//
//  Created by Jhonatan Alves on 22/12/21.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game: SoloSetGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
        }
    }
}

struct CardView: View {
    let card: SoloSetGame.Card
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        
        ZStack {
            shape
                .fill()
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 4)
            switch card.shape {
            case .diamond:
                Text("<>")
                    .font(.title)
                    .foregroundColor(.blue)
            case .oval:
                Text("o")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            case .rectangle:
                Text("[]")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }
        }
        .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        SoloSetGameView(game: game)
    }
}
