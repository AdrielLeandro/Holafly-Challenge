//
//  PokemonPageTests.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import XCTest
@testable import HolaFly_Challenge

final class PokemonPageTests: XCTestCase {

    func testPokemonPageDecoding() {
        let json = """
        {
            "count": 151,
            "next": "https://pokeapi.co/api/v2/pokemon?page=2",
            "results": [
                {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
                {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"}
            ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let pokemonPage = try decoder.decode(PokemonPage.self, from: json)
            XCTAssertEqual(pokemonPage.count, 151)
            XCTAssertEqual(pokemonPage.next, "https://pokeapi.co/api/v2/pokemon?page=2")
            XCTAssertEqual(pokemonPage.results.count, 2)
            XCTAssertEqual(pokemonPage.results[0].name, "bulbasaur")
            XCTAssertEqual(pokemonPage.results[0].url, "https://pokeapi.co/api/v2/pokemon/1/")
            XCTAssertEqual(pokemonPage.results[1].name, "ivysaur")
            XCTAssertEqual(pokemonPage.results[1].url, "https://pokeapi.co/api/v2/pokemon/2/")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
