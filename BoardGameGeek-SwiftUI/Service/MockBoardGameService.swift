//
//  MockBoardGameservice.swift
//  BoardGameGeekTests
//
//  Created by Nafisa Rahman on 30/1/2023.
//

import Foundation

final class MockBoardGameService: BoardGameServiceProtocol {

    func getData(urlString: String) async throws -> BoardGameService.Result {
        let networkTask = Task { () -> BoardGameService.Result in

            try await Task.sleep(nanoseconds: 1_000_000_000)

            return makeData(urlString: urlString)
        }

        let result = try await networkTask.value
        return result
    }

    func getImageData(url: URL) async throws -> Data {
        let session = URLSession.shared
        let (data, _) = try await session.data(from: url)
        return data
    }

}

private extension MockBoardGameService {

    func makeData(urlString: String) -> BoardGameService.Result {

        if urlString.contains("list") {
            return listData
        } else if urlString.contains("1234") {
            return detailData
        } else if urlString.contains("666") {
            return detailDataWithOnlyName
        } else {
            return .empty
        }
    }

    var detailData: BoardGameService.Result {
        BoardGameService.Result.detail(
            BoardGameDetails(
                objectID: "1234",
                name: "Ticket To Ride",
                yearPublished: "2022",
                minPlayer: 2,
                maxPlayer: 4,
                playingTime: 60,
                minPlayTime: 60,
                maxPlayTime: 120,
                age: 8,
                description: "Features familiar gameplay from the ticket to ride game",
                boardGameCategory: "Trains",
                boardGamePublisher: "Rebel",
                imageURL: ""
            )
        )
    }

    var detailDataWithOnlyName: BoardGameService.Result {
        BoardGameService.Result.detail(
            BoardGameDetails(
                objectID: "666",
                name: "Ticket To Ride",
                yearPublished: nil,
                minPlayer: nil,
                maxPlayer: nil,
                playingTime: nil,
                minPlayTime: nil,
                maxPlayTime: nil,
                age: nil,
                description: nil,
                boardGameCategory: nil,
                boardGamePublisher: nil,
                imageURL: nil
            )
        )
    }

    var listData: BoardGameService.Result {
        let boardGames = [
            BoardGame(id: "1234", name: "Ticket to Ride", yearPublished: 2020),
            BoardGame(id: "2345", name: "Ticket to Ride: Europe", yearPublished: 2022),
        ]

        return BoardGameService.Result.list(boardGames)
    }

}
