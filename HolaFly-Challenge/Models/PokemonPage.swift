//
//  PokemonPage.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [PokeItem]
}
