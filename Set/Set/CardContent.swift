//
//  CardContent.swift
//  Set
//
//  Created by Jhonatan Alves on 06/01/22.
//

import SwiftUI

struct CardContent: View {
    var card: SoloSetGame.Card
    var height: CGFloat
    
    var body: some View {
        ForEach(0..<card.number.rawValue, id: \.self) {_ in
            getCardShape(card: card)
                .frame(maxHeight: height / 6 )
                .foregroundColor(getCardColor(card: card))
        }
    }

    private func getCardColor(card: SoloSetGame.Card) -> Color {
        switch card.color {
        case .red:
            return Color.pink
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }

    @ViewBuilder
    private func getCardShape(card: SoloSetGame.Card) -> some View {
        switch card.shape {
        case .diamond:
            switch card.shading {
            case .solid:
                Diamond()
                    .fill()
            case .striped:
                Diamond()
                    .opacity(0.4)
            case .open:
                Diamond()
                    .stroke(lineWidth: 3)
            }
        case .rectangle:
            switch card.shading {
            case .solid:
                Rectangle()
                    .fill()
            case .striped:
                Rectangle()
                    .opacity(0.4)
            case .open:
                Rectangle()
                    .stroke(lineWidth: 3)
            }
        case .oval:
            switch card.shading {
            case .solid:
                Capsule()
                    .fill()
            case .striped:
                Capsule()
                    .opacity(0.4)
            case .open:
                Capsule()
                    .stroke(lineWidth: 3)
            }
        }
    }
}
