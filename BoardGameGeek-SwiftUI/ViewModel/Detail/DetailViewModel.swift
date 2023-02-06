//
//  DetailViewModel.swift
//  BoardGameGeek
//
//  Created by Nafisa Rahman on 27/1/2023.
//

import Foundation

/// Detail view model for the detail screen

@MainActor
final public class DetailViewModel: ObservableObject {

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

        /// API has encountered an error
        case error(Error)
    }

    // MARK: - properties

    private let boardGameService: BoardGameServiceProtocol
    private let boardGame: BoardGame?
    @Published private var boardGameDetails: BoardGameDetails?
    @Published var state: State = .idle
    @Published var isLearnMoreTapped = false

    /// Initializes a detail view model.
    ///
    /// - Parameters:
    ///    - boardGameService: The service to be used to fetch data from API.
    ///
    ///    - objectID: The identifier for a board game

    init(
        boardGameService: BoardGameServiceProtocol,
        boardGame: BoardGame?
    ) {
        self.boardGameService = boardGameService
        self.boardGame = boardGame
    }
    
}

public extension DetailViewModel {

    func fetchGameDetails() {
        Task { [weak self] in
            do {
                state = .loading
                try await self?.getGameDetails()
                state = .loaded
            } catch {
                state = .error(error)
            }
        }
    }

    /// Fetches the details of a selected board game from the BoardGameGeek API.

    func getGameDetails() async throws {
        if let objectID = boardGame?.id {
            let baseURL = "https://api.geekdo.com/xmlapi/boardgame/"

            do {
                let result = try await boardGameService.getData(urlString: baseURL + objectID)
                if case let .detail(boardGameDetails) = result {
                    self.boardGameDetails = boardGameDetails
                }
            } catch {
                throw error
            }
        } 
    }

}

public extension DetailViewModel {

    /// The name of a board game
    var name: String {
        boardGameDetails?.name ?? boardGame?.name ?? ""
    }

    /// The year the board game was published
    var year: String {
        if let boardGameDetails = boardGameDetails,
            let yearPublished = boardGameDetails.yearPublished {
            return yearPublished
        } else {
            if let boardGame = boardGame,
               let yearPublished = boardGame.yearPublished {
            return String(yearPublished)
            }
        }

        return ""
    }

    /// The description of the board game
    var description: String {
        guard let description = boardGameDetails?.description else { return "" }
        return description.removeXML()
    }

    /// The category of the board game
    var category: String {
        guard let category = boardGameDetails?.boardGameCategory else { return ""}
        return "Category: " + String(category)
    }

    /// Indicates whether category should be hidden
    var isCategoryHidden: Bool {
        category.isEmpty ? true : false
    }

    /// The publisher of the board game
    var publisher: String {
        guard let publisher = boardGameDetails?.boardGamePublisher else { return "" }
        return "Publisher: " + String(publisher)
    }

    /// Indicates whether publisher should be hidden
    var isPublisherHidden: Bool {
        publisher.isEmpty ? true : false
    }

    /// The minimum number of players required to play the board game
    var minPlayer: String {
        guard let minPlayer = boardGameDetails?.minPlayer else { return "" }
        return "Min Players: " + String(minPlayer)
    }

    /// Indicates whether minimum number of players should be hidden
    var isMinPlayerHidden: Bool {
        minPlayer.isEmpty ? true : false
    }

    /// The maximum number of players required to play the board game
    var maxPlayer: String {
        guard let maxPlayer = boardGameDetails?.maxPlayer else { return "" }
        return "Max Players: " + String(maxPlayer)
    }

    /// Indicates whether maximum number of players should be hidden
    var isMaxPlayerHidden: Bool {
        maxPlayer.isEmpty ? true : false
    }

    /// The image URL for the board game
    var imageURL: URL? {
        guard let imageURL = boardGameDetails?.imageURL,
              let url = URL(string: imageURL )
        else {
            return nil
        }
        return url
    }

    /// Indicates whether the image should be hidden
    var isImageHidden: Bool {
        imageURL == nil ? true : false
    }

    /// The age of players for the board game
    var age: String {
        guard let age = boardGameDetails?.age else { return "" }
        return "Age: " + String(age)
    }

    /// Indicates whether the age should be hidden
    var isAgeHidden: Bool {
        age.isEmpty ? true : false
    }

    /// The playing time of the board game
    var playingTime: String {
        guard let playingTime = boardGameDetails?.playingTime else { return "" }
        return "Playing Time: " + String(playingTime)
    }

    /// Indicates whether playing time should be hidden
    var isPlayingTimeHidden: Bool {
        playingTime.isEmpty ? true : false
    }

    /// The minimum playing time of the board game
    var minimumPlayingTime: String {
        guard let minimumPlayingTime = boardGameDetails?.minPlayTime else { return "" }
        return "Min Playing Time: " + String(minimumPlayingTime)
    }

    /// Indicates whether minimum playing time should be hidden
    var isMinimumPlayingTimeHidden: Bool {
        minimumPlayingTime.isEmpty ? true : false
    }

    /// The maximum playing time of the board game
    var maximumPlayingTime: String {
        guard let maximumPlayingTime = boardGameDetails?.maxPlayTime else { return "" }
        return "Max Playing Time: " + String(maximumPlayingTime)
    }

    /// Indicates whether maximum playing time should be hidden
    var isMaximumPlayingTimeHidden: Bool {
        maximumPlayingTime.isEmpty ? true : false
    }

}
