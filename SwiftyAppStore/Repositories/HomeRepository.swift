//
//  HomeRepository.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation

protocol HomeRepositoryProtocol: AnyObject {
    func fetchGames(completion: ([Game]) -> Void)
//    func getGameExtraDetail(by id: String, completion: (Game) -> Void)
}

final class HomeRepository: HomeRepositoryProtocol {
    private let apiService: HomeAPIServiceProtocol

    init(apiService: HomeAPIServiceProtocol = HomeAPIService()) {
        self.apiService = apiService
    }

    func fetchGames(completion: ([Game]) -> Void) {
        apiService.fetchGames(completion: completion)
    }

    func getGameExtraDetail(by id: String, completion: (Game) -> Void) {
//        apiService.getExtraDetails(id: id, completion: completion)
    }

}
