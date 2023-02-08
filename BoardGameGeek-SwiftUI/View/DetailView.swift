//
//  DetailView.swift
//  BoardGameGeek-SwiftUI
//
//  Created by Nafisa Rahman on 2/2/2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loaded:
                gameInfoView
                    .padding(20)
            case .loading:
                LoadingView()
            case .error(let error):
                ErrorView(errorText: error.localizedDescription)
            case .empty:
                NoResultView()
            }
        }
        .onAppear { viewModel.fetchGameDetails() }
    }
}

private extension DetailView {

    var gameInfoView: some View {
        VStack(alignment: .center, spacing: 20) {
            RoundedImageView(imageURL: viewModel.imageURL)

            VStack(spacing: 6) {
                Text(viewModel.name)
                    .centeredLargePrimaryText()

                Text(viewModel.year)
                    .centeredLargeSecondaryText()
            }

            ScrollView(.horizontal) {
                HStack {
                    TileView(
                        imageString: "person.2.circle.fill", imageTint: .blue,
                        tileInfo: viewModel.playingTime,
                        width: 100,
                        height: 100,
                        title: TileViewStyle.Title.primaryTitle,
                        borderColor: .blue
                    )
                    TileView(
                        imageString: "person.2.circle", imageTint: .green, tileInfo: viewModel.age,
                        width: 100,
                        height: 100,
                        title: TileViewStyle.Title.primaryTitle,
                        borderColor: .green
                    )
                    TileView(
                        imageString: "timer", imageTint: .red, tileInfo: viewModel.playerCount,
                        width: 100,
                        height: 100,
                        title: TileViewStyle.Title.primaryTitle,
                        borderColor: TileViewStyle.BorderColor.red
                    )
                }
                .padding(20)
            }

            ExpandableView(description: viewModel.description)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(boardGameService: MockBoardGameService(), boardGame: BoardGame(id: "1234", name: "Park")))
    }
}
