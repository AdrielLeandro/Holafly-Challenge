//
//  PokemonType.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 25/04/24.
//

import Foundation
import SwiftUI

enum PokemonType: String {
    case steel
    case water
    case bug
    case dragon
    case electric
    case ghost
    case fire
    case fairy
    case ice
    case fighting
    case normal
    case grass
    case psychic
    case rock
    case dark
    case ground
    case poison
    case flying
    
    var color: Color {
        return Color(rawValue.capitalized, bundle: nil)
    }
    
    var icon: Image {
        return Image("Icon\(rawValue.capitalized)", bundle: nil)
    }
}
