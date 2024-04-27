//
//  MainTabBarView.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 27/04/24.
//

import Foundation
import SwiftUI


struct MainTabBarView: View {
    
    var body: some View {
        TabView {
            ZStack {
                MainCoordinator()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            ZStack {
               Text("Comparator")
            }
            .tabItem {
                Label("Comparator", systemImage: "arrow.up.right.and.arrow.down.left")
            }
            
            ZStack {
                Text("Quiz")
            }
            .tabItem {
                Label("Quiz", systemImage: "questionmark.square")
            }
            
            ZStack {
                Text("Favorites")
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }
        }.accentColor(Color.black)
    }
}
