//
//  HomeRepository.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/30/22.
//

import Foundation
import Combine

// Repository is an overkill but for demo purposes ...
protocol HomeRepositoryProtocol: NetworkManagerProtocol {
    func fetchGames() -> AnyPublisher<[StoreApp], Error>
    func getGameExtraDetail(by id: String) -> AnyPublisher<StoreApp.ExtraDetail, Error>
}

final class HomeRepository: HomeRepositoryProtocol {
    let session: URLSession
    var baseURL: String = Constants.baseURL + "/apps"
    let bgQueue: DispatchQueue

    init(session: URLSession = URLSession.shared, queue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")) {
        self.session = session
        self.bgQueue = queue
    }

    func fetchGames() -> AnyPublisher<[StoreApp], Error> {
        return request(endpoint: API.allGames)
    }

    func getGameExtraDetail(by id: String) -> AnyPublisher<StoreApp.ExtraDetail, Error> {
        return request(endpoint: API.gameDetails(id))
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
