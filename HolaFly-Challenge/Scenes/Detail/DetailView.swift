//
//  DetailView.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 25/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            DetailHeaderView(pokemon: pokemon)
            
                VStack(alignment: .center, spacing: 20) {

                    VStack(alignment: .leading, spacing: 20) {
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundStyle(PokemonType(rawValue: pokemon.types.first?.type.name ?? "")?.color ?? .black)
                        ForEach(pokemon.types.indices, id: \.self) { index in
                            HStack {
                                PokemonType(rawValue: pokemon.types[index].type.name)?.icon.resizable().frame(width: Spacing.s30, height: Spacing.s30)
                                Text(pokemon.types[index].type.name.capitalized).font(.system(size: 20, weight: .semibold)).foregroundStyle(.black)
                            }
                        }
                        
                        Text("Abilities: \(pokemon.abilities.map { $0.ability.name }.joined(separator: ", "))")
                        Text("Moves: \(pokemon.moves.map { $0.move.name }.joined(separator: ", "))")

                    }.padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
        }.edgesIgnoringSafeArea(.top)
        .accentColor(.black)
    }
}

#Preview {
    DetailView(pokemon: Pokemon(id: 1,
                                name: "squirtle",
                                weight: 20, height: 30,
                                sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/7.png"))),
                                abilities: [Ability(ability: PokeItem(name: "", url: ""))],
                                moves: [Move(move: PokeItem(name: "", url: ""))],
                                types: [Type(type: PokeItem(name: "water", url: ""))]))
}
