//
//  Services.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

// MARK: - Enums

enum AppError: Error {
    case fileOpen
    case jsonParsing
    case unknown
    
    var errorDescription: String {
        switch self {
        case .fileOpen:
            return "An error occurred opening the file."
        case .jsonParsing:
            return "An error occurred while loading."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

class Services {
    
    // MARK: - Convenience Functions

    static func openFileNamed(name: String, fileExtension: String) -> Data? {
        guard let file = Bundle.main.url(forResource: name, withExtension: fileExtension) else { return nil }
        
        do {
            let result = try Data(contentsOf: file)
            return result
        } catch {
            return nil
        }
    }
    
}
