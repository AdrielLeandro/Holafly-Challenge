//
//  PokemonPageService.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation
import Combine

protocol PokemonPageServiceHandler {
    func fetchPage(url: String) -> AnyPublisher<PokemonPage, Error>
    func fetchPokemon(url: String) -> AnyPublisher<Pokemon, Error>
}

final class PokemonPageService: PokemonPageServiceHandler {
    private let manager: NetworkingManagerType
    init(manager: NetworkingManagerType) {
        self.manager = manager
    }
    func fetchPage(url: String) -> AnyPublisher<PokemonPage, Error> {
        return manager.fetchData(from: url)
    }
    func fetchPokemon(url: String) -> AnyPublisher<Pokemon, Error> {
        return manager.fetchData(from: url)
    }
}
