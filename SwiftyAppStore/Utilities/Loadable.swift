//
//  Loadable.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/31/22.
//

import Foundation
import SwiftUI

typealias LoadableSubject<Value> = Binding<Loadable<Value>>

enum Loadable<T> {
    case isLoading(last: T?, disposeBag: DisposeBag)
    case loaded(T)
    case failed(Error)

    var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last, _): return last
        default: return nil
        }
    }

    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
}

extension Loadable {
    mutating func setIsLoading(disposeBag: DisposeBag) {
        self = .isLoading(last: value, disposeBag: disposeBag)
    }

    mutating func dispose() {
        switch self {
        case let .isLoading(last, disposeBag):
            disposeBag.dispose()

            guard let last = last else {
                let error = NSError(
                    domain: NSCocoaErrorDomain,
                    code: NSUserCancelledError,
                    userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Canceled by user", comment: "")]
                )
                self = .failed(error)
                return
            }
            self = .loaded(last)
        default: break
        }
    }

    func map<V>(_ transform: (T) throws -> V) -> Loadable<V> {
        do {
            switch self {
            case let .failed(error): return .failed(error)
            case let .isLoading(value, db):
                return .isLoading(last: try value.map { try transform($0) },
                                  disposeBag: db)
            case let .loaded(value):
                return .loaded(try transform(value))

            }
        } catch {
            return .failed(error)
        }
    }
}

extension Loadable where T: SomeOptional {
    func unwrap() -> Loadable<T.Wrapped> {
        map { try $0.unwrap() }
    }
}

extension Loadable: Equatable where T: Equatable {
    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.isLoading(lhsV, _), .isLoading(rhsV, _)): return lhsV == rhsV
        case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
        case let (.failed(lhsE), .failed(rhsE)):
            return lhsE.localizedDescription == rhsE.localizedDescription
        default: return false
        }
    }
}
