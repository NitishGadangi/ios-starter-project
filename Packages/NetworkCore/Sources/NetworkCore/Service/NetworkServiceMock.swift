//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation

class NetworkServiceMock: NetworkServicable {
    func request(endPoint: any NetworkAPI, completion: @escaping NetworkServiceCompletion) {
        do {
            let bundle = Bundle.module
            let url = bundle.url(forResource: endPoint.mockResponseFileName, withExtension: "json", subdirectory: "MockResponses")
            if let url {
                let data = try Data(contentsOf: url)
                let dummyResponse = getDummySuccessResponse(endPoint: endPoint)
                completion(data, dummyResponse, nil)
            } else {
                let dummyResponse = getDummyErrorResponse(endPoint: endPoint)
                completion(nil, dummyResponse, nil)
            }
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func cancel() {
        // nothing to do here
    }
}

private extension NetworkServiceMock {
    func getDummySuccessResponse(endPoint: any NetworkAPI) -> HTTPURLResponse? {
        guard let url = URL(string: endPoint.baseUrl) else { return nil }
        return HTTPURLResponse(url: url,
                        statusCode: 200,
                        httpVersion: endPoint.scheme.rawValue,
                        headerFields: [:])
    }

    func getDummyErrorResponse(endPoint: any NetworkAPI) -> HTTPURLResponse? {
        guard let url = URL(string: endPoint.baseUrl) else { return nil }
        return HTTPURLResponse(url: url,
                        statusCode: 400,
                        httpVersion: endPoint.scheme.rawValue,
                        headerFields: [:])
    }
}
