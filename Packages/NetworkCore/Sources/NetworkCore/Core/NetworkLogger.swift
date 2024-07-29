//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation

protocol NetworkLogging: AnyObject {
    func logRequest(request: URLRequest)
    func logResponse(response: URLResponse)
}

class NetworkLogger: NetworkLogging {
    func logRequest(request: URLRequest) {
        print(request)
    }
    
    func logResponse(response: URLResponse) {
        print(response)
    }
}
