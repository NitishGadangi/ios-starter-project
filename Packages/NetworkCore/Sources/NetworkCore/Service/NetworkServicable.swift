//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation

typealias NetworkServiceCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->Void

protocol NetworkServicable {
    func request(endPoint: NetworkAPI, completion: @escaping NetworkServiceCompletion)
    func cancel()
}
