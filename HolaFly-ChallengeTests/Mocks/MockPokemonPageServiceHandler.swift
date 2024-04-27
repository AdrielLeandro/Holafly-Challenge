//
//  MockPokemonPageServiceHandler.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import Combine
import Foundation
@testable import HolaFly_Challenge

final class MockPokemonPageServiceHandler: PokemonPageServiceHandler {
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

    func fetchPokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        if let error = self.error {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let pokemon = pokemons[url] {
            return Just(pokemon).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            return Fail(error: MockError.notFound).eraseToAnyPublisher()
        }
    }

    enum MockError: Error {
        case notFound
    }
}
