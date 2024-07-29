//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}

enum ResponseResult {
    case success
    case failure(String)
}

extension NetworkManager {
    func handleResponse(_ response: HTTPURLResponse) -> ResponseResult {
        switch response.statusCode {
            case 200...299: 
                return .success
            case 401...500: 
                return .failure(NetworkResponse.authenticationError.rawValue)
            case 501...599: 
                return .failure(NetworkResponse.badRequest.rawValue)
            case 600: 
                return .failure(NetworkResponse.outdated.rawValue)
            default: 
                return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
