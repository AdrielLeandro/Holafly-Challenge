//
//  PokemonPageServiceTests.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import XCTest
import SwiftUI
import Combine
@testable import HolaFly_Challenge

final class PokemonPageServiceTests: XCTestCase {
    var service: PokemonPageService!
    var mockManager: MockNetworkingManager!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockManager = MockNetworkingManager()
        service = PokemonPageService(manager: mockManager)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testFetchPageSuccess() {
        let expectedPage = PokemonPage(count: 10, next: "nextURL", results: [])
        mockManager.setResponse(url: "testURL", response: expectedPage)

        let expectation = XCTestExpectation(description: "Fetch page succeeds")

        service.fetchPage(url: "testURL")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("Expected successful completion")
                }
            }, receiveValue: { page in
                XCTAssertEqual(page.count, expectedPage.count)
                XCTAssertEqual(page.next, expectedPage.next)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPageFailure() {
        mockManager.setError(MockNetworkingManager.MockError.genericError)

        let expectation = XCTestExpectation(description: "Fetch page fails")

        service.fetchPage(url: "testURL")
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error as? MockNetworkingManager.MockError, MockNetworkingManager.MockError.genericError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but received value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
