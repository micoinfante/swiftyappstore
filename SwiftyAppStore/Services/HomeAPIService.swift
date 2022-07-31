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

    let session: URLSession
    let baseURL: String = Constants.baseURL
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func fetchGames(completion: ([Game]) -> Void) {
        let games: [Game] = []
        completion(todayItems)
    }

//    func getExtraDetails(id: String, completion: (Game) -> Void) {
//        completion(Game())
//    }
}
