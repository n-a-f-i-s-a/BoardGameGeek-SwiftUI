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
                    .padding(30)
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

        VStack(alignment: .center, spacing: 10) {
            if viewModel.isImageHidden == false {
                AsyncImage(url: viewModel.imageURL)
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .shadow(radius: 3.0)
            }
            Text(viewModel.name)
                .centeredPrimaryText()

            Text(viewModel.year)
                .centeredSecondaryText()

            GeometryReader { geometry in
                VStack {
                    HStack {
                        TileView(
                            tileInfo: viewModel.playingTime,
                            width: geometry.size.width * 0.3,
                            height: 100,
                            title: TileViewStyle.Title.primaryTitle,
                            background: TileViewStyle.Background.blue
                        )
                        TileView(
                            tileInfo: viewModel.age,
                            width: geometry.size.width * 0.3,
                            height: 100,
                            title: TileViewStyle.Title.primaryTitle,
                            background: TileViewStyle.Background.green
                        )
                    }

                    if viewModel.isMinPlayerHidden == false {
                        Text(viewModel.minPlayer)
                            .centeredSecondaryText()
                    }

                    if viewModel.isMaxPlayerHidden == false {
                        Text(viewModel.maxPlayer)
                            .centeredSecondaryText()
                    }

                    if viewModel.isAgeHidden == false {
                        Text(viewModel.age)
                            .centeredSecondaryText()
                    }

                    if viewModel.isPlayingTimeHidden == false {
                        Text(viewModel.playingTime)
                            .centeredSecondaryText()
                    }

                    VStack {
                        Text(viewModel.description)
                            .multilineTextAlignment(.center)
                            .lineLimit(viewModel.isLearnMoreTapped ? nil : 2)

                        Button("Learn More"){
                            viewModel.isLearnMoreTapped.toggle()
                        }
                    }

                }

            }
        }
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(boardGameService: MockBoardGameService(), boardGame: BoardGame(id: "1234", name: "Park")))
    }
}
