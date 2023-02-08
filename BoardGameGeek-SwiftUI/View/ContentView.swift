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
                    LoadingView()
                case .loaded:
                    loadedSection
                case .empty:
                    NoResultView()
                case .idle:
                    EmptyView()
                case .error(let error):
                    ErrorView(errorText: error.localizedDescription)
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

    var loadedSection: some View {
        Section {
            ForEach(viewModel.boardGames) { boardGame in
                NavigationLink(destination: DetailView(viewModel: viewModel.selectItem(boardGame: boardGame))) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(boardGame.name)
                            .leadingPrimaryText()
                        Text(viewModel.getYear(boardGame: boardGame) ?? "")
                            .leadingSecondaryText()
                    }
                    .accessibility(hint: Text("Opens Game Details."))


                }
                .navigationBarTitleDisplayMode(.inline)

            }
            .listRowBackground(Color("Background"))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: BoardGameViewModel(boardGameService: MockBoardGameService()))
    }
}
