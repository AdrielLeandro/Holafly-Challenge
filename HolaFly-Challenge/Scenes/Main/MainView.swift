//
//  MainView.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    private let columns = [GridItem(.adaptive(minimum: 150, maximum: .infinity))]

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading && viewModel.searchResults.isEmpty {
                ProgressView()
            } else {
                Text("Pokedex").font(.system(size: 36))
                    .bold()
                    .padding(.horizontal).padding(.bottom, Spacing.s6)
                Text("Use the advanced search to find Pokémon by type, weakness, ability and more!")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                SearchBarView(searchText: $viewModel.searchText).padding()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Spacing.s10) {
                        ForEach(viewModel.searchResults) { pokemon in
                            ListItem(imageURL: pokemon.sprite.url,
                                     name: pokemon.name,
                                     number: pokemon.id,
                                     types: pokemon.types.map { $0.type.name }).onTapGesture {
                                self.viewModel.didTouchItem(with: pokemon)
                            } 
                        }
                    }.padding()
                }
            }
        }.onAppear {
            viewModel.fetchNextPage()
        }.alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct SearchTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color.mediumGray, lineWidth: 1)
        ).padding()
    }
}
