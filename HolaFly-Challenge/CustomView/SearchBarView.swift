//
//  SearchBarView.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 26/04/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
  
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search a pokémon", text: $searchText)
                    .autocorrectionDisabled()
                    .keyboardType(.alphabet)
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                searchText = ""
                                UIApplication.shared.endEditing()
                            }
                        , alignment: .trailing
                    )
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
                .foregroundColor(Color.mediumGray))
        }
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
