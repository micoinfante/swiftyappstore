//
//  Mock.swift
//  SwiftyAppStoreTests
//
//  Created by Mico Infante on 8/9/22.
//

import XCTest
@testable import SwiftyAppStore

protocol Mock {
    associatedtype Action: Equatable
    var actions: MockActions<Action> { get }
}

final class MockActions<Action> where Action: Equatable {
    let expected: [Action]
    var factual: [Action] = []

    init(expected: [Action]) {
        self.expected = expected
    }

    // TODO: Add Mock funcs
}
