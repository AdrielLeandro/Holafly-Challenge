//
//  MockPokemonPageServiceHandler.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import Combine
import Foundation
@testable import HolaFly_Challenge

final class MockPokemonPageServiceHandler: MainDataSourceHandler {
    var pages: [String: PokemonPage] = [:]
    var pokemons: [String: Pokemon] = [:]
    var error: Error?

    func setMockPage(url: String, page: PokemonPage) {
        pages[url] = page
    }

    func setMockPokemon(url: String, pokemon: Pokemon) {
        pokemons[url] = pokemon
    }

    func setCommonError(_ error: Error) {
        self.error = error
    }

    func fetchPage(url: String) -> AnyPublisher<PokemonPage, Error> {
        if let error = self.error {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let page = pages[url] {
            return Just(page).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: MockError.notFound).eraseToAnyPublisher()
        }
    }

    func fetchDatails(url: String) -> AnyPublisher<Pokemon, Error> {
        if let error = self.error {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let pokemon = pokemons[url] {
            return Just(pokemon).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: MockError.notFound).eraseToAnyPublisher()
        }
    }
    
    func fetchLocalData() -> [Pokemon] {
        let pokemon1 = Pokemon(id: 24, name: "Pikachu", weight: 10, height: 10, sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: ""))), abilities: [], moves: [], types: [])
        let pokemon2 = Pokemon(id: 24, name: "Squirtle", weight: 10, height: 10, sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: ""))), abilities: [], moves: [], types: [])
        let pokemon3 = Pokemon(id: 24, name: "Charmander", weight: 10, height: 10, sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: ""))), abilities: [], moves: [], types: [])
        return [pokemon1, pokemon2, pokemon3]
    }
    
    func fetchLocalPage() -> PokemonPage? {
        let pokemon1 = Pokemon(id: 24, name: "Pikachu", weight: 10, height: 10, sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: ""))), abilities: [], moves: [], types: [])
        let pokemon2 = Pokemon(id: 24, name: "Squirtle", weight: 10, height: 10, sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: ""))), abilities: [], moves: [], types: [])
        let pokemon3 = Pokemon(id: 24, name: "Charmander", weight: 10, height: 10, sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: ""))), abilities: [], moves: [], types: [])
        let results = [pokemon1, pokemon2, pokemon3]
        return PokemonPage(count: results.count, next: "", results: [])
    }
    enum MockError: Error {
        case notFound
    }
}
