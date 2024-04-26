//
//  NetworkingManager.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation
import Combine

protocol NetworkingManagerType: AnyObject {
    func fetchData<T: Decodable>(from url: String) -> AnyPublisher<T, Error>
}

class NetworkingManager: NetworkingManagerType {
    func fetchData<T: Decodable>(from url: String) -> AnyPublisher<T, Error> where T: Decodable {
        return fetchData(from: url, attemp: 1)
    }
    
    private func fetchData<T: Decodable>(from stringURL: String, attemp: Int) -> AnyPublisher<T, Error> {
        guard let url = URL(string: stringURL) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url).tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            switch httpResponse.statusCode {
            case 200..<300:
                return data
            case 400..<600:
                throw URLError(.badServerResponse)
            default:
                throw URLError(.unknown)
            }
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .retry(3)
        .eraseToAnyPublisher()
    }
}
