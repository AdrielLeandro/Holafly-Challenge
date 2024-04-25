//
//  RequestError.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation

struct RequestError: Error {
    enum KeyError: String {
        case requestFailed
        case invalidData
        case invalidURL
        case parsingError
        case invalidServerResponse
        case clientError
    }
    
    let key: KeyError
    let message: String
}
