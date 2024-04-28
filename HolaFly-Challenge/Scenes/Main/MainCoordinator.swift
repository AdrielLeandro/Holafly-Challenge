//
//  MainCoordinator.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import SwiftUI

struct MainCoordinator: View {
    enum Path: Hashable {
        case detail(pokemon: Pokemon)
    }
    
    @State private var navigationPath = NavigationPath()
    
    private var rootView: some View {
        MainView(viewModel: MainViewModel(coordinator: self,
                                          dataSource: MainDataSource(manager: NetworkingManager(),
                                                                     fileManagerService: FileManagerService()), 
                                          fileManagerService: FileManagerService()))
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            rootView.navigationDestination(for: Path.self, destination: destinationView(for:))
        }.accentColor(.black)
    }
    
    @ViewBuilder
    private func destinationView(for nextView: Path) -> some View {
        Group {
            switch nextView {
            case .detail(let pokemon):
                DetailView(pokemon: pokemon)
            }
        }
    }
    
    func showDetailView(with pokemon: Pokemon) {
        navigationPath.append(Path.detail(pokemon: pokemon))
    }
}
