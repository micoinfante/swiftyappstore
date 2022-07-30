//
//  HomeViewModel.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var games: [Game] = []

    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }

    func onAppear() {
        repository.fetchGames { games in
            self.games = games
        }
    }
}
