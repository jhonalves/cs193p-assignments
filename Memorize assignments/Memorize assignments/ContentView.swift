//
//  ContentView.swift
//  Memorize assignments
//
//  Created by Jhonatan Alves on 07/11/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack {
                Text(viewModel.currentTheme.name).font(.largeTitle)
                Spacer()
                VStack {
                    Text("Score").font(.title)
                    Text(String(viewModel.score)).font(.largeTitle).foregroundColor(scoreColor(viewModel.score))
                }
            }
            .padding()
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(themeColor(viewModel.currentTheme.color))
            .padding()
            Spacer()
            Button (action: {
                viewModel.newGame()
            }, label: {
                Text("New Game").font(.largeTitle)
            })
            .padding()
        }
    }
    
    func themeColor(_ colorName: String) -> Color {
        switch colorName {
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "orange":
            return Color.orange
        case "green":
            return Color.green
        case "brown":
            return Color.brown
        case "pink":
            return Color.pink
            
        default:
            return Color.red
        }
    }
    
    func scoreColor(_ score: Int) -> Color {
        var color = Color.primary
        
        if score > 0 {
            color = Color.green
        } else if score < 0 {
            color = Color.red
        } else {
            color = Color.primary
        }
        
        return color
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        
        ZStack {
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 4)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
