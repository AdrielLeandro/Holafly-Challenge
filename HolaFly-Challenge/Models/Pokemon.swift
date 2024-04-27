//
//  Pokemon.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation

struct Pokemon: Codable, Identifiable {
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

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Sprite: Codable {
    let url: String
    let other: OtherSprite
    
    enum CodingKeys: String, CodingKey {
        case url = "front_default"
        case other
    }
}

struct OtherSprite: Codable {
    let home: HomeSprite
}

struct HomeSprite: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

struct Ability: Codable {
    let ability: PokeItem
}

extension Ability: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ability.name)
    }
    
    static func == (lhs: Ability, rhs: Ability) -> Bool {
        return lhs.ability.name == rhs.ability.name
    }
}

struct Move: Codable {
    let move: PokeItem
}

struct Type: Codable {
    let type: PokeItem
}

extension Type: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type.name)
    }
    
    static func == (lhs: Type, rhs: Type) -> Bool {
        return lhs.type.name == rhs.type.name
    }
}
