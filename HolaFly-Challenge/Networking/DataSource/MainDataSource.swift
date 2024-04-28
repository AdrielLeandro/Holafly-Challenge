//
//  MainDataSource.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation
import Combine
import SwiftUI

protocol MainDataSourceHandler {
    func fetchPage(url: String) -> AnyPublisher<PokemonPage, Error>
    func fetchDatails(url: String) -> AnyPublisher<Pokemon, Error>
    func fetchLocalData() -> [Pokemon]
    func fetchLocalPage() -> PokemonPage?
}

class MainDataSource: MainDataSourceHandler {
    private let manager: NetworkingManagerType
    private let fileManagerService: FileManagerServiceHandler
    
    init(manager: NetworkingManagerType, fileManagerService: FileManagerServiceHandler) {
        self.manager = manager
        self.fileManagerService = fileManagerService
    }
    
    func fetchPage(url: String) -> AnyPublisher<PokemonPage, Error> {
        return manager.fetchData(from: url)
    }
    
    func fetchDatails(url: String) -> AnyPublisher<Pokemon, Error> {
        return manager.fetchData(from: url)
    }
    
    func fetchLocalData() -> [Pokemon] {
        if let pokemonList = fileManagerService.loadFromFile("pokemonList", as: [Pokemon].self) {
            return pokemonList
        }
        return []
    }
    
    func fetchLocalPage() -> PokemonPage? {
        if let page = fileManagerService.loadFromFile("page", as: PokemonPage.self) {
            return page
        }
        return nil
    }
}
