//
//  API.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/31/22.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}
