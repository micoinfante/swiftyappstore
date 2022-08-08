//
//  Async.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 8/5/22.
//

import Foundation

final class Async {
    static func main(_ action: @escaping () -> Void) {
        DispatchQueue.main.async(execute: action)
    }

    static func main(after interval: Int, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + interval.toDispatchTime(), execute: action)
    }
}

final class Sync {
    static func main(_ action: () -> Void) {
        DispatchQueue.main.sync(execute: action)
    }
}

extension Int {
    func toDispatchTime() -> DispatchTimeInterval {
        return DispatchTimeInterval.seconds(self)
    }
}
