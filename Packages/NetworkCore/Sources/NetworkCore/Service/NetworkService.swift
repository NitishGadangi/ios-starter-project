//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation

class NetworkService: NetworkServicable {
    private let session: URLSession
    private var task: URLSessionTask?
    private let logger: NetworkLogging

    init(session: URLSession = URLSession(configuration: .default), logger: NetworkLogging = NetworkLogger()) {
        self.session = session
        self.logger = logger
    }

    func request(endPoint: any NetworkAPI, completion: @escaping NetworkServiceCompletion) {
        let urlComponents = buildURLComponents(endPoint: endPoint)
        let urlRequest = buildURLRequest(components: urlComponents, endPoint: endPoint)
        guard let urlRequest else {
            completion(nil, nil, NetworkError(message: "Invalid Network API"))
            return
        }
        task = session.dataTask(with: urlRequest, completionHandler: completion)
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}

private extension NetworkService {
    func buildURLComponents(endPoint: any NetworkAPI) -> URLComponents {
        var components = URLComponents()
        components.scheme = endPoint.scheme.rawValue
        components.host = endPoint.baseUrl
        components.path = endPoint.path
        components.queryItems = endPoint.params
        return components
    }

    func buildURLRequest(components: URLComponents, endPoint: any NetworkAPI) -> URLRequest? {
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10)
        request.httpMethod = endPoint.httpMethod.rawValue
        switch endPoint.task {
            case .request(let headers):
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                for (key, value) in headers {
                    request.addValue(value, forHTTPHeaderField: key)
                }
        }
        return request
    }
}
