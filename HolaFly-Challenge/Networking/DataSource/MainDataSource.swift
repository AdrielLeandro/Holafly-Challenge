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
    func fetchDatails(from item: PokeItem) -> AnyPublisher<Pokemon, Error>
}

class MainDataSource: MainDataSourceHandler {
    private let manager: NetworkingManagerType
    private let fileManagerService: FileManagerServiceHandler
    
    init(manager: NetworkingManagerType, fileManagerService: FileManagerServiceHandler) {
        self.manager = manager
        self.fileManagerService = fileManagerService
    }
    
    func fetchPage(url: String) -> AnyPublisher<PokemonPage, Error> {
        let localPublisher: AnyPublisher<PokemonPage?, Error> = Just(fileManagerService.loadFromFile("pokemonPage", as: PokemonPage.self)).setFailureType(to: Error.self).eraseToAnyPublisher()
        
        let remotePublisher: AnyPublisher<PokemonPage, Error> = manager.fetchData(from: url)
            .handleEvents(receiveOutput: { [weak self] pokemonPage in
                self?.fileManagerService.saveToFile(pokemonPage, fileName: "pokemonPage")
            }).eraseToAnyPublisher()
        
        return remotePublisher
            .catch { _ in localPublisher.compactMap { $0 } }
            .eraseToAnyPublisher()
    }
    
    func fetchDatails(from item: PokeItem) -> AnyPublisher<Pokemon, Error> {
        let localPublisher: AnyPublisher<Pokemon?, Error> = Just(fileManagerService.loadFromFile(item.name, as: Pokemon.self))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let remotePublisher: AnyPublisher<Pokemon, Error> = manager.fetchData(from: item.url)
            .handleEvents(receiveOutput: { [weak self] pokemon in
//                self?.fileManagerService.saveToFile(pokemon, fileName: pokemon.name)
            })
            .eraseToAnyPublisher()
        
        return remotePublisher
            .catch { error -> AnyPublisher<Pokemon, Error> in
                print("Error fetching remote data:", error)
                
                return localPublisher.map { localDetail -> AnyPublisher<Pokemon, Error> in
                    if localDetail = localDetail {
                    }
                    
                }.eraseToAnyPublisher()
                
            }.eraseToAnyPublisher()
    }
}
