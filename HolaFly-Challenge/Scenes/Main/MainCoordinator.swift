//
//  MainCoordinator.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import SwiftUI

final struct MainCoordinator: View {
    enum Path: Hashable {
        case detail
    }
    @State private var navigationPath = NavigationPath()
    
    private var rootView: some View {
        MainView(viewModel: MainViewModel())
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            rootView.navigationDestination(for: Path.self, destination: destinationView(for:))
        }
    }
    
    @ViewBuilder
    private func destinationView(for nextView: Path) -> some View {
        Group {
            switch nextView {
            case .detail:
                Text("detail")
            }
        }
    }
}
