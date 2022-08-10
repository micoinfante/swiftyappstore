//
//  MockedResponse.swift
//  SwiftyAppStoreTests
//
//  Created by Mico Infante on 8/10/22.
//

import Foundation
@testable import SwiftyAppStore

extension MockedRequest {
    struct MockedResponse {
        let url: URL
        let result: Result<Data, Swift.Error>
        let httpCode: HTTPCode
        let headers: [String: String]
        let loadingTime: TimeInterval
        let customResponse: URLResponse?
    }
}

extension MockedRequest.MockedResponse {
    enum Error: Swift.Error {
        case mockCreationFailed
    }

    init(url: URL, result: Result<Data, Swift.Error>) {
        self.url = url
        self.result = result
        httpCode = 200
        headers = [String: String]()
        loadingTime = 0
        customResponse = nil
    }

    init<T>(apiCall: APICall,
            baseURL: String = "https://swiftyappstore.test.com/",
            result: Result<T, Swift.Error>,
            headers: [String: String] = ["Content-Type": "application/json"],
            httpCode: HTTPCode = 200,
            loadingTime: TimeInterval = 0.1) throws where T: Encodable {
        guard let url = try apiCall.urlRequest(baseURL: baseURL).url else {
            throw Error.mockCreationFailed
        }

        self.url = url
        switch result {
        case let .success(value):
            self.result = .success(try JSONEncoder().encode(value))
        case let .failure(error):
            self.result = .failure(error)
        }
        self.httpCode = httpCode
        self.headers = headers
        self.loadingTime = loadingTime
        customResponse = nil
    }

    init(apiCall: APICall, baseURL: String, customResponse: URLResponse) throws {
        guard let url = try apiCall.urlRequest(baseURL: baseURL).url
        else { throw Error.mockCreationFailed }
        self.url = url
        result = .success(Data())
        httpCode = 200
        headers = [String: String]()
        loadingTime = 0
        self.customResponse = customResponse
    }
}
