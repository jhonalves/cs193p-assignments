//
//  EmojiMemoryGame.swift
//  Memorize assignments
//
//  Created by Jhonatan Alves on 11/11/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    struct Theme {
        var name: String
        var contentSet: Array<String>
        var numberOfPairsToShow: Int
        var color: String
    }
    
    private var themes: Array<Theme>
    private var usedTheme: Theme
    
    func createMemoryGame(_ theme: Theme, numberOfPairsOfCards: Int) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            theme.contentSet[pairIndex]
        }
    }

    @Published private var model: MemoryGame<String>

    init() {
        
        func createMemoryGame(_ theme: Theme, numberOfPairsOfCards: Int) -> MemoryGame<String> {
            MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
                theme.contentSet[pairIndex]
            }
        }
        
        let sportsTheme = Theme(name: "Sports", contentSet: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🪁", "🏹", "🎣", "🤿"], numberOfPairsToShow: 8, color: "green")
        let foodTheme = Theme(name: "Foods", contentSet: ["🌭", "🍔", "🍟", "🍕", "🫓", "🥪", "🥙", "🧆", "🌮", "🌯", "🫔", "🥗", "🥘", "🫕", "🥫", "🍝", "🍜", "🍲", "🍛", "🍣", "🍱", "🥟"], numberOfPairsToShow: 6, color: "red")
        let vehiclesTheme = Theme(name: "Vehicles", contentSet: ["🚗", "🚎", "🏎", "🚂", "✈️", "🚀", "🛸", "🚁", "⛵️", "🛳", "🚅", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺",  "🚓", "🚑", "🚒", "🚌", "🚐", "🛻", "🚚"], numberOfPairsToShow: 7, color: "blue")
        let animalsTheme = Theme(name: "Animals", contentSet: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"], numberOfPairsToShow: 7, color: "brown")
        let emojisTheme = Theme(name: "Emojis", contentSet: ["😃", "😁", "😅", "😂", "🥲", "😊", "😇", "🙃", "😉", "😌", "😍", "🥰", "😘", "😋", "😛", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🥳", "😏", "😒", "😔", "☹️", "🥺", "😢", "😭", "😱", "😰", "😓", "🤗", "🤔", "🤭", "😑", "😬", "🙄", "😴", "🥴"], numberOfPairsToShow: 9, color: "orange")
        let heartsTheme = Theme(name: "Hearts", contentSet: ["❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "❤️‍🔥", "❤️‍🩹", "❣️", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "💟"], numberOfPairsToShow: 5, color: "pink")
        
        themes = [sportsTheme, foodTheme, vehiclesTheme, animalsTheme, emojisTheme, heartsTheme]
        usedTheme = sportsTheme
        
        if let newTheme = themes.randomElement() {
            usedTheme = newTheme
            let pairsQuantity: Int
            if newTheme.numberOfPairsToShow < newTheme.contentSet.count {
                pairsQuantity = newTheme.numberOfPairsToShow
            } else {
                pairsQuantity = newTheme.contentSet.count
            }
            
            model = createMemoryGame(newTheme, numberOfPairsOfCards: pairsQuantity)
        }
        else {
            model = createMemoryGame(usedTheme, numberOfPairsOfCards: usedTheme.numberOfPairsToShow)
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var currentTheme: Theme {
        usedTheme
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        if let newTheme = themes.randomElement() {
            usedTheme = newTheme
            let pairsQuantity: Int
            if newTheme.numberOfPairsToShow < newTheme.contentSet.count {
                pairsQuantity = newTheme.numberOfPairsToShow
            } else {
                pairsQuantity = newTheme.contentSet.count
            }
                
            model = createMemoryGame(newTheme, numberOfPairsOfCards: pairsQuantity)
        }
    }
}

