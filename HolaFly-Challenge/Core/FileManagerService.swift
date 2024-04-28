//
//  FileManagerService.swift
//  HolaFly-Challenge
//
//  Created by Adriel Pinzas on 26/04/24.
//

import Foundation

protocol FileManagerServiceHandler {
    func saveToFile<T: Codable>(_ data: T, fileName: String)
    func loadFromFile<T: Codable>(_ fileName: String, as type: T.Type) -> T?
}

struct FileManagerService: FileManagerServiceHandler {
    func saveToFile<T: Codable>(_ data: T, fileName: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            guard let fileURL = getFileURL(for: fileName) else {
                return
            }
            try encodedData.write(to: fileURL)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func loadFromFile<T: Codable>(_ fileName: String, as type: T.Type) -> T? {
        guard let fileURL = getFileURL(for: fileName) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData
        } catch {
            print("Error loading data: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func getFileURL(for fileName: String) -> URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentsDirectory?.appendingPathComponent(fileName)
        return fileURL
    }
}
