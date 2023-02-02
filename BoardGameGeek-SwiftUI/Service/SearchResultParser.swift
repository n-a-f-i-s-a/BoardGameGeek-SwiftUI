//
//  SearchResultParser.swift
//  BoardGameGeek
//
//  Created by Nafisa Rahman on 26/1/2023.
//

import Foundation

/// A parser for parsing the search result fetched from an API

final class SearchResultParser: NSObject {

    // MARK: - properties

    private var boardGames: [BoardGame]
    private var currentValue: String

    override init() {
        boardGames = []
        currentValue = ""
    }
}

extension SearchResultParser: ParserProtocol {

    /// Returns the parsed result
    ///
    /// - Parameters:
    ///    - data: The data fetched from an API.
    /// - Returns: Parsed results.

    func parseResult(data: Data) -> BoardGameService.Result {
        var parser = XMLParser()
        parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()

        return .list(boardGames)
    }
    
}

// MARK: - XMLParserDelegate

extension SearchResultParser:  XMLParserDelegate {

    func parserDidStartDocument(_ parser: XMLParser) {
        boardGames.removeAll()
    }

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]) {
            for (key, val) in attributeDict {
                if (key == "objectid") {
                    boardGames.append(
                        BoardGame(
                            id: val,
                            name: "",
                            yearPublished: nil
                        )
                    )
                }
            }
        }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        guard boardGames.isEmpty == false else { return }

        if elementName == "name" {
            boardGames[boardGames.count - 1].name = currentValue
        } else if elementName == "yearpublished" {
            if currentValue.isEmpty == false {
                boardGames[boardGames.count - 1].yearPublished = Int(currentValue)
            }
        }
        currentValue = ""
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.isEmpty == false {
            currentValue += string
        }
    }

}
