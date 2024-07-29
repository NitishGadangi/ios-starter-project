//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 10/07/24.
//

import Foundation

public extension Collection {

    /// Use this to safely get element from index without causing out of bounds exception.
    /// Usage: array[safe: index]
    @inline(__always) subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
