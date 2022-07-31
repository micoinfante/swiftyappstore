//
//  HomeAPIService.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation

protocol HomeAPIServiceProtocol: AnyObject {
    func fetchGames(completion: ([Game]) -> Void)
//    func getExtraDetails(id: String, completion: (Game) -> Void)
}

final class HomeAPIService: HomeAPIServiceProtocol {
    func fetchGames(completion: ([Game]) -> Void) {
        let games: [Game] = []
        completion(todayItems)
    }

//    func getExtraDetails(id: String, completion: (Game) -> Void) {
//        completion(Game())
//    }
}
