//
//  ContentView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 2/2/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: BoardGameViewModel

    init(viewModel: BoardGameViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                switch viewModel.state{
                case .loading:
                    loadingSection
                case .loaded:
                    loadedSection
                case .empty:
                    emptySection
                case .idle:
                    idleSection
                }
            }
        }
        .searchable(
            text: $viewModel.searchString,
            prompt: "Search a board game"
        )
        .onSubmit(of: .search) { viewModel.searchGames() }
    }
}

private extension ContentView {

    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }

    var loadingSection: some View {
        Section {
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.secondaryTitleColor))
                Spacer()
            }
        }

    }

    var loadedSection: some View {
        Section {
            ForEach(viewModel.boardGames) { boardGame in
                NavigationLink(destination: DetailView(viewModel: viewModel.selectItem(boardGame: boardGame))) {
                    VStack {
                        Text(boardGame.name)
                        Text(viewModel.getYear(boardGame: boardGame) ?? "")
                    }
                }
            }
        }
    }

    var idleSection: some View {
        Section {}
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: BoardGameViewModel(boardGameService: MockBoardGameService()))
    }
}
