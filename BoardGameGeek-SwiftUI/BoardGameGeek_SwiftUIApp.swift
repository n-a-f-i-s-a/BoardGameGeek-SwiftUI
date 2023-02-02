//
//  BoardGameGeek_SwiftUIApp.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 2/2/2023.
//

import SwiftUI

@main
struct BoardGameGeek_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: BoardGameViewModel(boardGameService: BoardGameService(parser: SearchResultParser())))
        }
    }
}
