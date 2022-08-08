//
//  NetworkRepository.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/31/22.
//

import Foundation
import Combine
import SwiftUI

protocol NetworkManagerProtocol {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

extension NetworkManagerProtocol {
    func request<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            session.configuration.timeoutIntervalForRequest = Constants.Network.TIME_OUT
            return session.dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes = .success) -> AnyPublisher<Data, Error> {
        print("Publish resp")
        return tryMap {
            guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                print("No response")
                throw APIError.unacceptableResponse
            }

            guard httpCodes.contains(code) else {
                print("APi error")
                throw APIError.httpCode(code)
            }
            print("Data got \($0.0)")
            return $0.0
        }
        .mapError {
            print("Map error")
            return ($0.underlyingError as? Failure) ?? $0
        }
        .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {

        print("Req json")
        return requestData(httpCodes: httpCodes)
            .decode(type: Value.self, decoder: jsonDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func withRetry(_ retries: Int = Constants.Network.MAX_RETRIES) -> Publishers.Retry<Self> {
        return retry(retries)
    }

    func withSecuredTime(_ time: Double = Constants.Network.MIN_TIME) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Failure> {
        return ensureTimeSpan(time)
    }
}
