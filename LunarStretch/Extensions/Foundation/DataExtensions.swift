//
//  DataExtensions.swift
//  ValorInstructor
//
//  Created by Eric Ziegler on 9/28/21.
//

import Foundation

extension Data {
   
    mutating func appendString(string: String) {
        guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            return
        }
        self.append(data)
    }
    
}
