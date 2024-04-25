//
//  Pokemon.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let sprite: Sprite
    let abilities: [Ability]
    let moves: [Move]
    let types: [Type]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weight
        case height
        case sprite = "sprites"
        case abilities
        case moves
        case types
    }
}

struct Sprite: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

struct Ability: Decodable {
    let ability: PokeItem
}

struct Move: Decodable {
    let move: PokeItem
}

struct Type: Decodable {
    let type: PokeItem
}
