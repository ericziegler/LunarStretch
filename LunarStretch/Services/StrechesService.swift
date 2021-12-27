//
//  StrechesService.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

// MARK: - Services

class StretchesService {
    
    // MARK: - Constants
    
    private static let stretchesFileName = "stretches"
    private static let stretchesFileExtension = "json"
    
    // MARK: - Loading
 
    func fetchStretches() -> [StretchInfo]? {
        guard let data = Services.openFileNamed(name: StretchesService.stretchesFileName, fileExtension: StretchesService.stretchesFileExtension) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let stretches = try decoder.decode([StretchInfo].self, from: data)
            return stretches
        } catch {
            return nil
        }
    }
    
}
