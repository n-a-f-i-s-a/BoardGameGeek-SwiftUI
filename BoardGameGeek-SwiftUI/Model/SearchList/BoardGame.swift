//
//  BoardGameModel.swift
//  BoardGameGeek
//
//  Created by Nafisa Rahman on 24/1/2023.
//

import Foundation

/// A Board Game.

struct BoardGame: Identifiable, Hashable {
    /// The game Identifier
    var id: String
    /// The name of the game
    var name: String
    /// The year the game was published
    var yearPublished: Int?
}
