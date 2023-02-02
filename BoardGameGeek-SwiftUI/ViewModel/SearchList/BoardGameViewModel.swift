//
//  BoardGameViewModel.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 2/2/2023.
//

import Foundation
import SwiftUI

/// View model for the board game list.

@MainActor
final public class BoardGameViewModel: ObservableObject {

    // MARK: - Type

    /// Different states.
    public enum State {
        /// User hasn't searched.
        case idle

        /// Data is being fetched.
        case loading

        /// Data has been loaded.
        case loaded

        /// API has not returned any data.
        case empty
    }

    // MARK: - properties

    private let boardGameService: BoardGameServiceProtocol
    @Published var boardGames: [BoardGame]
    @Published var state: State
    @Published var searchString = ""

    /// Initializes a view model.
    ///
    /// - Parameters:
    ///    - boardGameService: The service to be used to fetch data from API.

    init(boardGameService: BoardGameServiceProtocol) {
        self.boardGameService = boardGameService
        self.boardGames = []
        self.state = .idle
    }
}

extension BoardGameViewModel {

    func searchGames() {
        Task { [weak self] in
            do {
                self?.boardGames = []
                self?.state = .loading

                try await self?.getGames(searchString: searchString)
            } catch {
                // error
            }
        }
    }

    /// Fetches the board games from the BoardGameGeek API.
    /// Sorts the board games by year published.
    ///
    /// - Parameters:
    ///     - searchString: The name of a board game.

    func getGames(searchString: String) async throws {
        let baseURL = "https://api.geekdo.com/xmlapi/search?search="

        do {
            let result = try await boardGameService.getData(urlString: baseURL + searchString)
            if case let .list(boardGames) = result {
                if boardGames.isEmpty && state != .idle {
                    state = .empty
                } else {
                    self.boardGames = boardGames.sorted(by: { $0.yearPublished ?? .min > $1.yearPublished ?? .min })
                    state = .loaded
                }
            }
        } catch {
            throw error
        }
    }

    /// Returns the pushedViewModel for the next screen.
    ///
    /// - Parameters:
    ///     - row: The row index to obtain the corresponding object ID.
    ///  - Returns: A view model to be pushed.

    func selectItem(boardGame: BoardGame) -> DetailViewModel {
        if ProcessInfo.processInfo.arguments.contains("Testing") {
            return DetailViewModel(
                boardGameService: MockBoardGameService(),
                boardGame: boardGame
            )

        } else {
            return DetailViewModel(
                boardGameService: BoardGameService(parser: DetailParser()),
                boardGame: boardGame
            )
        }
    }
    
}

extension BoardGameViewModel {

    /// Returns the pushedViewModel for the next screen.
    ///
    /// - Parameters:
    ///     - boardGame: A board game object.
    ///  - Returns: The year the board game was published.

    func getYear(boardGame: BoardGame) -> String? {
        if let yearPublished = boardGame.yearPublished {
            return "Year Published: " + String(yearPublished)
        }
        return nil
    }

}
