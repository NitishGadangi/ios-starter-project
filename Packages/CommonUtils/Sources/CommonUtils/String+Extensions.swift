//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation

extension Optional where Wrapped == String {
    var emptyOnNil: String {
        return self ?? ""
    }
}
