//
//  PokemonPageService.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation

protocol PokemonPageServiceHandler {
    func fetchPokemonPage(url: String,completion: @escaping (Result<PokemonPage, RequestError>) -> Void)
}

class PokemonPageService: PokemonPageServiceHandler {
    let manager: NetworkingManager
    
    init(manager: NetworkingManager) {
        self.manager = manager
    }
    
    func fetchPokemonPage(url: String, completion: @escaping (Result<PokemonPage, RequestError>) -> Void) {
        manager.fetchData(from: url, completion: completion)
    }
}
