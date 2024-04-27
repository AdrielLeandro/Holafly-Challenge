//
//  PokemonTests.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import XCTest
@testable import HolaFly_Challenge

final class PokemonTests: XCTestCase {

    func testPokemonDecoding() {
        let json = """
        {
            "id": 1,
            "name": "bulbasaur",
            "weight": 69,
            "height": 7,
            "sprites": {
                "front_default": "https://example.com/sprite.png",
                "other": {
                    "home": {
                        "front_default": "https://example.com/home.png"
                    }
                }
            },
            "abilities": [
                {"ability": {"name": "overgrow", "url": "https://example.com/ability1"}},
                {"ability": {"name": "chlorophyll", "url": "https://example.com/ability2"}}
            ],
            "moves": [
                {"move": {"name": "tackle", "url": "https://example.com/move1"}},
                {"move": {"name": "vine whip", "url": "https://example.com/move2"}}
            ],
            "types": [
                {"type": {"name": "grass", "url": "https://example.com/type1"}},
                {"type": {"name": "poison", "url": "https://example.com/type2"}}
            ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let pokemon = try decoder.decode(Pokemon.self, from: json)
            XCTAssertEqual(pokemon.id, 1)
            XCTAssertEqual(pokemon.name, "bulbasaur")
            XCTAssertEqual(pokemon.weight, 69)
            XCTAssertEqual(pokemon.height, 7)
            XCTAssertEqual(pokemon.sprite.url, "https://example.com/sprite.png")
            XCTAssertEqual(pokemon.sprite.other.home.url, "https://example.com/home.png")
            XCTAssertEqual(pokemon.abilities.count, 2)
            XCTAssertEqual(pokemon.abilities[0].ability.name, "overgrow")
            XCTAssertEqual(pokemon.abilities[1].ability.name, "chlorophyll")
            XCTAssertEqual(pokemon.moves.count, 2)
            XCTAssertEqual(pokemon.moves[0].move.name, "tackle")
            XCTAssertEqual(pokemon.moves[1].move.name, "vine whip")
            XCTAssertEqual(pokemon.types.count, 2)
            XCTAssertEqual(pokemon.types[0].type.name, "grass")
            XCTAssertEqual(pokemon.types[1].type.name, "poison")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
