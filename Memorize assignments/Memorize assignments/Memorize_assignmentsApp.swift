//
//  Memorize_assignmentsApp.swift
//  Memorize assignments
//
//  Created by Jhonatan Alves on 11/11/21.
//

import SwiftUI

@main
struct Memorize_assignmentsApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
