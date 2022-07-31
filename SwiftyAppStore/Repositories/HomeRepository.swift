//
//  HomeRepository.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation

// Repository is an overkill but for demo purposes ...
protocol HomeRepositoryProtocol: NetworkManagerProtocol {
    func fetchGames(completion: ([Game]) -> Void)
//    func getGameExtraDetail(by id: String, completion: (Game) -> Void)
}

final class HomeRepository: HomeRepositoryProtocol {
    var session: URLSession = URLSession.shared
    var baseURL: String = ""
    var bgQueue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")

    private let apiService: HomeAPIServiceProtocol

    init(apiService: HomeAPIServiceProtocol = HomeAPIService()) {
        self.apiService = apiService
    }

    func fetchGames(completion: ([Game]) -> Void) {

    }

    func getGameExtraDetail(by id: String, completion: (Game) -> Void) {
        
    }

}

// Service Endpoints
extension HomeRepository {
    enum API {
        case allGames
        case gameDetails(String)
    }
}

// Actual endpoints
extension HomeRepository.API: APICall {
    var path: String {
        switch self {
        case .allGames:
            return "/"
        case let .gameDetails(id):
            return "/game/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .allGames, .gameDetails: return .get
        }
    }

    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }

    // Edit for .post, .update
    func body() throws -> Data? {
        return nil
    }
}
