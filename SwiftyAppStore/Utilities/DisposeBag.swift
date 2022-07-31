//
//  DisposeBag.swift
//  SwiftyAppStore
//
//  Created by Mico Infante on 7/31/22.
//

import Combine

final class DisposeBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    func dispose() {
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in disposeBag: DisposeBag) {
        disposeBag.subscriptions.insert(self)
    }
}
