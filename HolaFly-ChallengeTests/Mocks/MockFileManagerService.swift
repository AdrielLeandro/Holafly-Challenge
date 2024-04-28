//
//  MockFileManagerService.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import Foundation
import XCTest
@testable import HolaFly_Challenge

class MockFileManagerService: FileManagerServiceHandler {
    var savedData: [String: Data] = [:]
    var loadDataReturnValue: Result<Data, Error>?
    var saveDataError: Error?

    func saveToFile<T: Codable>(_ data: T, fileName: String) {
        if let error = saveDataError {
            XCTFail("Unexpected call to saveToFile. Error: \(error.localizedDescription)")
            return
        }
        do {
            let encodedData = try JSONEncoder().encode(data)
            savedData[fileName] = encodedData
        } catch {
            XCTFail("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func loadFromFile<T: Codable>(_ fileName: String, as type: T.Type) -> T? {
        if let error = saveDataError {
            XCTFail("Unexpected call to loadFromFile. Error: \(error.localizedDescription)")
            return nil
        }
        if let returnValue = loadDataReturnValue {
            switch returnValue {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(type, from: data)
                    return decodedData
                } catch {
                    XCTFail("Error decoding data: \(error.localizedDescription)")
                    return nil
                }
            case .failure(let error):
                XCTFail("Error loading data: \(error.localizedDescription)")
                return nil
            }
        } else {
            XCTFail("Unexpected call to loadFromFile.")
            return nil
        }
    }
}
