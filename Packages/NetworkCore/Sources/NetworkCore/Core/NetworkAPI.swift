//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation

public protocol NetworkAPI {
    var scheme: HTTPScheme { get }
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var params: [URLQueryItem]? { get }
    var task: HTTPTask { get }
    var mockResponseFileName: String? { get }
}

public extension NetworkAPI {
    var mockResponseFileName: String? {
        return nil
    }
}
