//
//  PokeItemTests.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import XCTest
@testable import HolaFly_Challenge

final class PokeItemTests: XCTestCase {

    func testPokeItemDecoding() {
        let json = """
        {
            "name": "pikachu",
            "url": "https://pokeapi.co/api/v2/pokemon/pikachu"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let pokeItem = try decoder.decode(PokeItem.self, from: json)
            XCTAssertEqual(pokeItem.name, "pikachu")
            XCTAssertEqual(pokeItem.url, "https://pokeapi.co/api/v2/pokemon/pikachu")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}

