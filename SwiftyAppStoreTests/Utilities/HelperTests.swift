//
//  HelperTests.swift
//  SwiftyAppStoreTests
//
//  Created by Mico Infante on 8/9/22.
//

import XCTest

@testable import SwiftyAppStore

class HelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_result() {
        let successResult = Result<Void, Error>.success(())
        let failedResult = Result<Void, Error>.failure(NSError.test)

        XCTAssertTrue(successResult.isSuccess)
        XCTAssertFalse(failedResult.isSuccess)
    }

    func test_toURL() {
        let invalid = "1293081234"
        XCTAssertEqual(invalid.toURL, URL(string: "")!)

        let valid = "https://www.google.com"
        XCTAssertEqual(valid.toURL, URL(string: "https://www.google.com")!)
    }

    func test_today_date() {
        let date = Date()
        XCTAssertNotNil(date.today)
    }

    func test_nserror_test() {
        XCTAssertEqual(NSError.test.domain, "Test Error")
    }

}
