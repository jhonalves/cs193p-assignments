//
//  SetApp.swift
//  Set
//
//  Created by Jhonatan Alves on 22/12/21.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SoloSetGame()
    
    var body: some Scene {
        WindowGroup {
            SoloSetGameView(game: game)
        }
    }
}
