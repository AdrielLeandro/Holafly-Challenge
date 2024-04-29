//
//  MainView.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import SwiftUI

struct MainView: View {
    private struct Constant {
        static let gridMinimumValue: CGFloat = 150
    }
    
    @ObservedObject var viewModel: MainViewModel
    private let columns = [GridItem(.adaptive(minimum: Constant.gridMinimumValue, maximum: .infinity))]
    @State private var isAbilityFilterShowing = false

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading && viewModel.searchResults.isEmpty {
                Spacer()
                ProgressView()
                Spacer()
            } else if viewModel.searchResults.isEmpty {
                EmptyView {
                    viewModel.handlerAlert()
                }
            } else {
                Text("Pokedex").font(.system(size: 36))
                    .bold()
                    .padding(.horizontal).padding(.bottom, Spacing.s6)
                Text("Use the advanced search to find Pokémon by type, weakness, ability and more!")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                SearchBarView(searchText: $viewModel.searchText, didTouchFilter: {
                    isAbilityFilterShowing = true
                }).padding()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Spacing.s10) {
                        ForEach(viewModel.searchResults, id: \.id) { pokemon in
                            ListItem(imageURL: pokemon.sprite.url,
                                     name: pokemon.name,
                                     number: pokemon.id,
                                     types: pokemon.types.map { $0.type.name }).onTapGesture {
                                self.viewModel.didTouchItem(with: pokemon)
                            }.onAppear {
                                viewModel.fetchNextPage(pokemon: pokemon)
                            }
                        }
                    }.padding()
                }.scrollDismissesKeyboard(.immediately)
            }
        }.onAppear {
            viewModel.setupInitialPage()
        }.sheet(isPresented: $isAbilityFilterShowing) {
            FilterView(abilityFilters: $viewModel.abilitiesFilters, typeFilters: $viewModel.typeFilters, isShowing: $isAbilityFilterShowing) .onDisappear {
                    viewModel.objectWillChange.send()
            }
        }.alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct EmptyView: View {
    var onTap: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: "exclamationmark.triangle").resizable().frame(width: 100, height: 100).padding()
            Text("An unexpected error has occurred").padding()
            Button {
                onTap?()
            } label: {
                Text("Retry")
            }
            Spacer()
        }
    }
}
