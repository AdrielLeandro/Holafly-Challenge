//
//  DetailHeaderView.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 25/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailHeaderView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [PokemonType(rawValue: pokemon.types.first?.type.name ?? "")?.color ?? .black,
                                    ( PokemonType(rawValue: pokemon.types.first?.type.name ?? "")?.color ?? .black).opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                WebImage(url: URL(string: pokemon.sprite.other.home.url)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView().frame(height: 150)
                }
                HStack {
                    Text("Height: \(pokemon.height)").font(.system(size: 24).bold()).foregroundStyle(.white)
                    Spacer()
                    Text("Weight: \(pokemon.weight)").font(.system(size: 24).bold()).foregroundStyle(.white)
                }.padding(.horizontal, 50).padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    DetailHeaderView(pokemon: Pokemon(id: 1,
                                      name: "squirtle",
                                      weight: 20, height: 30,
                                      sprite: Sprite(url: "", other: OtherSprite(home: HomeSprite(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/7.png"))),
                                      abilities: [Ability(ability: PokeItem(name: "", url: ""))],
                                      moves: [Move(move: PokeItem(name: "", url: ""))],
                                      types: [Type(type: PokeItem(name: "water", url: ""))]))
}
