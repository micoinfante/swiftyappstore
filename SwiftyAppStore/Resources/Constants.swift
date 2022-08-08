//
//  Constants.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/31/22.
//

import Foundation

struct Constants {
    private static var transportProtocol: String {
        return "https"
    }
    static var baseURL: String {
        return "\(transportProtocol)://62ecc6df55d2bd170e868662.mockapi.io/api/v1"
    }

    struct Network {
        static let MAX_RETRIES: Int = 3
        static let MIN_TIME: Double = 0.5
        static let TIME_OUT: Double = 15
    }
}
