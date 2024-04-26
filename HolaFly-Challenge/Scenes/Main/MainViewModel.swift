//
//  MainViewModel.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    private let service = PokemonPageService(manager: NetworkingManager())
    private var pokemonPage: PokemonPage? = nil
    private let initialPage = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=150"
    @Published var pokemonList: [Pokemon] = []
    @Published var isLoading = false
    @State var showErrorAlert = false
    @State var errorMessage = ""
    private var cancellables = Set<AnyCancellable>()
    private let coordinator: MainCoordinator
    private var nextPage: Bool = false
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    private func fetchData(stringUrl: String) {
        isLoading = true
        service.fetchPage(url: stringUrl)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showErrorAlert = true
                    self.isLoading = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.updatePokemonList(with: response)
            })
            .store(in: &cancellables)
    }
    
    private func updatePokemonList(with response: PokemonPage) {
        pokemonPage = response
        let fetchPokemonPublishers = response.results.map { service.fetchPokemon(url: $0.url) }
        Publishers.MergeMany(fetchPokemonPublishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showErrorAlert = true
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] pokemonList in
                guard let self = self else { return }
                self.pokemonList += pokemonList.sorted(by: { $0.id < $1.id })
            })
            .store(in: &cancellables)
    }
    
    func fetchNextPage() {
        guard let pokemonPage = pokemonPage else {
            fetchData(stringUrl: initialPage)
            return
        }
        
        if nextPage {
            fetchData(stringUrl: pokemonPage.next)
        }
    }
    
    func didTouchItem(with pokemon: Pokemon) {
        coordinator.showDetailView(with: pokemon)
    }
}
