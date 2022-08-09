//
//  Helpers.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/31/22.
//

import Foundation

extension Result {
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
}

extension String {
    var toURL: URL {
        guard let url = URL(string: self) else {
            return URL(string: "")!
        }
        return url
    }
}

extension Date {

    /// returns a string format(EEEE d MMMM) of today's date
    func today() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM"

        return dateFormatter.string(from: self)
    }
}
