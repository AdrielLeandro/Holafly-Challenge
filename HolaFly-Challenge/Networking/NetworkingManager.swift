//
//  NetworkingManager.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 24/04/24.
//

import Foundation

protocol NetworkingManagerType: AnyObject {
    func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, RequestError>) -> Void)
}


class NetworkingManager: NetworkingManagerType {
    func fetchData<T>(from url: String, completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        fetchData(from: url, attempt: 1, completion: completion)
    }
    
    private func fetchData<T: Decodable>(from url: String, attempt: Int, completion: @escaping (Result<T, RequestError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(RequestError(key: .invalidURL, message: "Invalid URL")))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(RequestError(key: .requestFailed, message: error.localizedDescription)))
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(RequestError(key: .requestFailed, message: "Error http response")))
                return
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decoder.decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(RequestError(key: .parsingError, message: error.localizedDescription)))
                    }
                } else {
                    completion(.failure(RequestError(key: .invalidServerResponse, message: "Invalid server response")))
                }
            case 400..<500:
                completion(.failure(RequestError(key: .clientError, message: "Client error")))
            case 500..<600:
                // Retry logic
                if attempt < 5 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                        self.fetchData(from: url.absoluteString, attempt: attempt + 1, completion: completion)
                    }
                } else {
                    completion(.failure(RequestError(key: .requestFailed, message: "Request failed after 5 attempts")))
                }
            default:
                completion(.failure(RequestError(key: .requestFailed, message: "Request failed")))
            }
        }
    
        task.resume()
    }
}
