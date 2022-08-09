//
//  LoadableTests.swift
//  SwiftyAppStoreTests
//
//  Created by Mico Infante on 8/9/22.
//

import XCTest
import Combine
@testable import SwiftyAppStore

class LoadableTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_disposable() {
        let db1 = DisposeBag()
        let db2 = DisposeBag()
        let subject = PassthroughSubject<Int, Never>()

        subject.sink {_ in }
            .store(in: db1)
        subject.sink { _ in }
            .store(in: db2)

        // Has value
        var someLoadable1 = Loadable<Int>.isLoading(last: 99, disposeBag: db1)
        XCTAssertEqual(db1.subscriptions.count, 1)
        someLoadable1.dispose()
        XCTAssertEqual(db1.subscriptions.count, 0)
        XCTAssertEqual(someLoadable1.value, 99)

        // Nil/Error
        var someLoadable2 = Loadable<Int>.isLoading(last: nil, disposeBag: db1)
        XCTAssertEqual(db2.subscriptions.count, 1)
        someLoadable2.dispose()
        XCTAssertEqual(db2.subscriptions.count, 0)
        XCTAssertNotNil(someLoadable2.error)
    }

    func test_helpers() {
        let idle = Loadable<Int>.notRequested
        let loadingValue = Loadable<Int>.isLoading(last: 99, disposeBag: DisposeBag())
        let loadingNil = Loadable<Int>.isLoading(last: nil, disposeBag: DisposeBag())
        let loaded = Loadable<Int>.loaded(2)
        let failedValue = Loadable<Int>.failed(NSError.init(domain: "Test Error", code: 0, userInfo: nil))

        XCTAssertNil(idle.value)
        XCTAssertNil(loadingNil)

        XCTAssertNotNil(loadingValue.value)
        XCTAssertNotNil(loaded.value)
        XCTAssertNotNil(failedValue.error)
    }

}
