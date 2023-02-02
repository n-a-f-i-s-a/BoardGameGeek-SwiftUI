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
            VStack(alignment: .center, spacing: 8) {
                Text(viewModel.name)
                Text(viewModel.year)
                Text(viewModel.minPlayer)
                Text(viewModel.maxPlayer)
                Text(viewModel.age)
                Text(viewModel.description)

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
