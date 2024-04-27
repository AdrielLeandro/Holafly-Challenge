//
//  Filter.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 27/04/24.
//

import SwiftUI

enum FilterOption {
    case ability(Ability)
    case type(Type)
}

struct Filter {
    let option: FilterOption
    var isSelected: Bool
}
