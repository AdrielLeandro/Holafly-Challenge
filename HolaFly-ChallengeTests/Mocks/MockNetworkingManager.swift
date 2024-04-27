//
//  MockNetworkingManager.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import Combine
import Foundation
@testable import HolaFly_Challenge

final class MockNetworkingManager: NetworkingManagerType {
    var responses: [String: Any] = [:]
    var error: Error?

    func fetchData<T>(from url: String) -> AnyPublisher<T, Error> where T : Decodable {
        if let error = self.error {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let response = responses[url] as? T {
            return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: MockError.notFound).eraseToAnyPublisher()
        }
    }

    func setResponse<T: Decodable>(url: String, response: T) {
        responses[url] = response
    }

    func setError(_ error: Error) {
        self.error = error
    }

    enum MockError: Error {
        case notFound
        case genericError
    }
}
