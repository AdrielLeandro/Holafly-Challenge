//
//  FilterView.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 27/04/24.
//

import SwiftUI

struct FilterView: View {
    @Binding var abilityFilters: [Filter]
    @Binding var typeFilters: [Filter]
    @Binding var isShowing: Bool
    @State private var selectedSegment: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Filter By:")
                    .font(.headline)
                    .padding()
                Spacer()
                Button {
                    abilityFilters.indices.forEach { abilityFilters[$0].isSelected = false }
                    typeFilters.indices.forEach { typeFilters[$0].isSelected = false }
                    isShowing = false
                } label: {
                    Text("Clear")
                }
            }.padding()
            Picker(selection: $selectedSegment, label: Text("Filters")) {
                Text("Abilities").tag(0)
                Text("Types").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedSegment == 0 {
                FilterList(filters: $abilityFilters, isShowing: $isShowing)
            } else {
                FilterList(filters: $typeFilters, isShowing: $isShowing)
            }
        }
    }
}

struct FilterList: View {
    @Binding var filters: [Filter]
    @Binding var isShowing: Bool

    var body: some View {
        List {
            ForEach(filters.indices, id: \.self) { index in
                Button(action: {
                    self.filters[index].isSelected.toggle()
                    self.isShowing = false
                }) {
                    HStack {
                        switch filters[index].option {
                        case .ability(let ability):
                            Text("Ability: \(ability.ability.name)").foregroundStyle(.black)
                        case .type(let type):
                            HStack {
                                PokemonType(rawValue: type.type.name)?.icon.resizable().frame(width: Spacing.s20, height: Spacing.s20)
                                Text(type.type.name.capitalized).font(.system(size: 13, weight: .semibold)).foregroundStyle(.black)
                            }
                        }
                        Spacer()
                        if filters[index].isSelected {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}
