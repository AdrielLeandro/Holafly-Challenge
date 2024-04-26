//
//  ListItem.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListItem: View {
    let imageURL: String
    let name: String
    let number: Int
    let types: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text(name.capitalized).foregroundStyle(.white)
                Spacer()
                Text("#\(number)").foregroundStyle(.white)
            }.padding()
            HStack {
                VStack(alignment: .leading) {
                    ForEach(types.indices, id: \.self) { index in
                        HStack {
                            PokemonType(rawValue: types[index])?.icon.resizable().frame(width: Spacing.s20, height: Spacing.s20)
                            Text(types[index].capitalized).font(.system(size: 13, weight: .semibold)).foregroundStyle(.white)
                        }
                    }
                }.padding(.leading, Spacing.s10)
                VStack {
                    WebImage(url: URL(string: imageURL)) { image in
                        image.resizable().scaledToFill().frame(width: Spacing.s84, height: Spacing.s84)
                    } placeholder: {
                        ProgressView().frame(width: Spacing.s84, height: Spacing.s84)
                    }
                }
            }
        }.background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(PokemonType(rawValue: types.first ?? "")?.color)
                .overlay(
                    GeometryReader { geometry in
                        Image("backgroundImage")
                            .resizable()
                            .foregroundColor(.white)
                            .opacity(0.4)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width / 1.5, height: geometry.size.height / 1.5)
                            .clipped()
                            .offset(x: geometry.size.width / 2 - geometry.size.width / 8, y: geometry.size.height / 2)
                    }
                )
        )
    }
}
