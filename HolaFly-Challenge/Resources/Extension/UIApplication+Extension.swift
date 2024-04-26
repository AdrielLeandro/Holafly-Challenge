//
//  UIApplication+Extension.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 26/04/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

