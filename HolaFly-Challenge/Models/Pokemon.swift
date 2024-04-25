//
//  Pokemon.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation

struct Pokemon: Decodable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let url: String
}
