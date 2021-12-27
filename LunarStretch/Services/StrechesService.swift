//
//  StrechesService.swift
//  LunarStretch
//
//  Created by Eric Ziegler on 12/27/21.
//

import Foundation

// MARK: - TypeAliases

typealias StretchesCompletionBlock = (_ result: [StretchInfo]?, _ error: AppError?) -> ()

// MARK: - Services

class StretchesService {
    
    // MARK: - Constants
    
    private let stretchesFileName = "stretches"
    private let stretchesFileExtension = "json"
    
    // MARK: - Loading
 
    func fetchStretches(completion: StretchesCompletionBlock?) {
        guard let data = Services.openFileNamed(name: stretchesFileName, fileExtension: stretchesFileExtension) else {
            completion?(nil, .fileOpen)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let stretches = try decoder.decode([StretchInfo].self, from: data)
            completion?(stretches, nil)
        } catch {
            completion?(nil, .jsonParsing)
        }
    }
    
}
