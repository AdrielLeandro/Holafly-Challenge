//
//  MainViewModel.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    private let coordinator: MainCoordinator
    private let dataSource: MainDataSourceHandler
    private let fileManagerService: FileManagerServiceHandler
    private var pokemonPage: PokemonPage? = nil
    private let initialPage = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=150"
    @Published var pokemonList: [Pokemon] = []
    
    var searchResults: [Pokemon] {
        var filteredPokemonList = pokemonList
        
        let selectedAbilities = abilitiesFilters.filter { $0.isSelected }.compactMap {
            if case .ability(let ability) = $0.option {
                return ability
            }
            return nil
        }
        
        if !selectedAbilities.isEmpty {
            filteredPokemonList = filteredPokemonList.filter { pokemon in
                return selectedAbilities.allSatisfy { ability in
                    return pokemon.abilities.contains { $0.ability.name == ability.ability.name }
                }
            }
        }
        
        let selectedTypes = typeFilters.filter { $0.isSelected }.compactMap {
            if case .type(let type) = $0.option {
                return type
            }
            return nil
        }
        
        if !selectedTypes.isEmpty {
            filteredPokemonList = filteredPokemonList.filter { pokemon in
                return selectedTypes.allSatisfy { type in
                    return pokemon.types.contains { $0.type.name == type.type.name }
                }
            }
        }
        
        if !searchText.isEmpty {
            filteredPokemonList = filteredPokemonList.filter { $0.name.localizedStandardContains(searchText) }
        }
        
        return filteredPokemonList
    }
    
    var abilitiesFilters: [Filter] = []
    var typeFilters: [Filter] = []
    
    @Published var isLoading = false
    @Published var searchText = ""
    @State var showErrorAlert = false
    @State var errorMessage = ""
    private var cancellables = Set<AnyCancellable>()
    private var nextPage: Bool = false
    
    init(coordinator: MainCoordinator, dataSource: MainDataSourceHandler, fileManagerService: FileManagerServiceHandler) {
        self.coordinator = coordinator
        self.dataSource = dataSource
        self.fileManagerService = fileManagerService
    }
    
    private func fetchData(stringUrl: String) {
        isLoading = true
        dataSource.fetchPage(url: stringUrl)
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
                self.fileManagerService.saveToFile(response, fileName: "page")
                self.pokemonPage = response
                self.updatePokemonList(with: response)
            })
            .store(in: &cancellables)
    }
    
    private func updatePokemonList(with response: PokemonPage) {
        let fetchPokemonPublishers = response.results.map { dataSource.fetchDatails(url: $0.url) }
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
                    self.initFilterList()
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] newPokemonList in
                guard let self = self else { return }
                let uniqueCombinedList = Set(pokemonList + newPokemonList)
                pokemonList = Array(uniqueCombinedList).sorted(by: { $0.id < $1.id })
                fileManagerService.saveToFile(self.pokemonList, fileName: "pokemonList")
            })
            .store(in: &cancellables)
    }
    
    func intialPage() {
        loadLocalData()
        loadLocalPage()
        initFilterList()
    }
    
    private func loadLocalData() {
        guard pokemonList.isEmpty else { return }
        
        let localList = dataSource.fetchLocalData()
        guard !localList.isEmpty else { return }
        
        pokemonList = localList.sorted(by: { $0.id < $1.id })
    }
    
    private func loadLocalPage() {
        guard pokemonPage == nil else { return }
        
        if let localPage = fileManagerService.loadFromFile("page", as: PokemonPage.self) {
            pokemonPage = localPage
        } else {
            fetchData(stringUrl: initialPage)
        }
    }
    
    func fetchNextPage(pokemon: Pokemon) {
        let lastIndex = pokemonList.count - 1
        
        if pokemonList[lastIndex] == pokemon {
            if let page = pokemonPage {
                fetchData(stringUrl: page.next)
            }
        }
    }
    
    private func initFilterList() {
        let abilitySet = Set(pokemonList.flatMap { $0.abilities })
        let typeSet = Set(pokemonList.flatMap { $0.types })
        let abilityFilters = Array(abilitySet).map { Filter.init(option: .ability($0), isSelected: false)}
        let typeFilters = Array(typeSet).map { Filter(option: .type($0), isSelected: false) }
        self.abilitiesFilters = abilityFilters
        self.typeFilters = typeFilters
    }
    
    func didTouchItem(with pokemon: Pokemon) {
        coordinator.showDetailView(with: pokemon)
    }
}
