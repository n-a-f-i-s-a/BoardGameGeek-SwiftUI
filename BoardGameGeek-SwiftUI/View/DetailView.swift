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
            VStack(alignment: .center, spacing: 10) {
                if viewModel.isImageHidden == false {
                    AsyncImage(url: viewModel.imageURL)
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                }
                Text(viewModel.name)
                    .centeredPrimaryText()

                Text(viewModel.year)
                    .centeredSecondaryText()

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

                Text(viewModel.description)
                    .multilineTextAlignment(.center)

            }
            .padding(30)
            .onAppear { viewModel.fetchGameDetails() }
        }
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(boardGameService: MockBoardGameService(), boardGame: BoardGame(id: "1234", name: "Park")))
    }
}
