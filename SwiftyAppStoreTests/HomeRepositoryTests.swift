//
//  HomeRepositoryTests.swift
//  SwiftyAppStoreTests
//
//  Created by Mico Infante on 8/10/22.
//

import XCTest
import Combine
@testable import SwiftyAppStore

class HomeRepositoryTests: XCTestCase {

    typealias API = HomeRepository.API
    typealias Mock = MockedRequest.MockedResponse

    private var repo: HomeRepository!
    private var subs = Set<AnyCancellable>()

    override func setUp() {
        subs = Set<AnyCancellable>()
        repo = HomeRepository(session: .mockedResponsesOnly)
    }

    override func tearDown() {
        MockedRequest.removeAllMocks()
    }

    // MARK: - All Apps

    func test_fetchGames() throws {
        let data = StoreApp.mockedData
        try mock(.allGames, result: .success(data))

        let exp = XCTestExpectation(description: "Completion")
        repo.fetchGames().sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subs)
        wait(for: [exp], timeout: 2)
    }

    func test_extraDetail() throws {
        let apps = StoreApp.mockedData
        let extraDetail = StoreApp.ExtraDetail.mockedData.first!
        try mock(.gameDetails(apps.first!.i), result: .success(extraDetail))
        let exp = XCTestExpectation(description: "Completion")

        repo.getGameExtraDetail(by: "1").sinkToResult { result in
            result.assertFailure(nil)
            exp.fulfill()
        }.store(in: &subs)
        wait(for: [exp], timeout: 2)
    }


    // MARK: - Helper

    private func mock<T>(_ apiCall: API, result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(apiCall: apiCall, baseURL: repo.baseURL, result: result, httpCode: httpCode)
        MockedRequest.add(mock)
    }
}

extension Result where Success: Equatable {
    func assertSuccess(value: Success, file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(resultValue):
            XCTAssertEqual(resultValue, value, file: file, line: line)
        case let .failure(error):
            XCTFail("Unexpected error: \(error)", file: file, line: line)
        }
    }
}

extension Result where Success == Void {
    func assertSuccess(file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .failure(error):
            XCTFail("Unexpected error: \(error)", file: file, line: line)
        case .success:
            break
        }
    }
}

extension Result {
    func assertFailure(_ message: String? = nil, file: StaticString = #file, line: UInt = #line) {
        switch self {
        case let .success(value):
            XCTFail("Unexpected success: \(value)", file: file, line: line)
        case let .failure(error):
            if let message = message {
                XCTAssertEqual(error.localizedDescription, message, file: file, line: line)
            }
        }
    }
}

extension Result {
    func publish() -> AnyPublisher<Success, Failure> {
        return publisher.publish()
    }
}

extension Publisher {
    func publish() -> AnyPublisher<Output, Failure> {
        delay(for: .milliseconds(10), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - XCTestCase
func XCTAssertEqual<T>(_ expression1: @autoclosure () throws -> T,
                       _ expression2: @autoclosure () throws -> T,
                       removing prefixes: [String],
                       file: StaticString = #file, line: UInt = #line) where T: Equatable {
    do {
        let exp1 = try expression1()
        let exp2 = try expression2()
        if exp1 != exp2 {
            let desc1 = prefixes.reduce(String(describing: exp1), { (str, prefix) in
                str.replacingOccurrences(of: prefix, with: "")
            })
            let desc2 = prefixes.reduce(String(describing: exp2), { (str, prefix) in
                str.replacingOccurrences(of: prefix, with: "")
            })
            XCTFail("XCTAssertEqual failed:\n\n\(desc1)\n\nis not equal to\n\n\(desc2)", file: file, line: line)
        }
    } catch {
        XCTFail("Unexpected exception: \(error)")
    }
}

protocol PrefixRemovable { }

extension PrefixRemovable {
    static var prefixes: [String] {
        let name = String(reflecting: Self.self)
        var components = name.components(separatedBy: ".")
        let module = components.removeFirst()
        let fullTypeName = components.joined(separator: ".")
        return [
            "\(module).",
            "Loadable<\(fullTypeName)>",
            "Loadable<LazyList<\(fullTypeName)>>"
        ]
    }
}

// MARK: - BindingWithPublisher
struct BindingWithPublisher<Value> {

    let binding: Binding<Value>
    let updatesRecorder: AnyPublisher<[Value], Never>

    init(value: Value, recordingTimeInterval: TimeInterval = 0.5) {
        var value = value
        var updates = [value]
        binding = Binding<Value>(
            get: { value },
            set: { value = $0; updates.append($0) })
        updatesRecorder = Future<[Value], Never> { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + recordingTimeInterval) {
                completion(.success(updates))
            }
        }.eraseToAnyPublisher()
    }
}
