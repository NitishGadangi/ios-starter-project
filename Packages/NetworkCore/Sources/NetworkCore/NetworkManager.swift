//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 29/07/24.
//

import Foundation

public protocol NetworkManagable {
    func sendRequest<T: Decodable>(endpoint: NetworkAPI, completion: @escaping (Result<T, Error>) -> Void)
}

public enum NetworkManagerEnv {
    case prod
    case stage
}

public class NetworkManager: NetworkManagable {

    private let networkService: NetworkServicable

    public init(env: NetworkManagerEnv = .prod) {
        switch env {
            case .prod:
                networkService = NetworkService()
            case .stage:
                networkService = NetworkServiceMock()
        }
    }

    public func sendRequest<T>(endpoint: any NetworkAPI, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        networkService.request(endPoint: endpoint) { data, response, error in
            if error != nil {
                let networkError = NetworkError(message: NetworkResponse.failed.rawValue)
                completion(.failure(networkError))
            }

            guard let response = response as? HTTPURLResponse 
            else {
                let networkError = NetworkError(message: NetworkResponse.failed.rawValue)
                completion(.failure(networkError))
                return
            }

            let handledResponse = self.handleResponse(response)
            switch handledResponse {
                case .success:
                    guard let responseData = data else {
                        let networkError = NetworkError(message: NetworkResponse.noData.rawValue)
                        completion(.failure(networkError))
                        return
                    }

                    do {
                        let jsonDecoded = try JSONDecoder().decode(T.self, from: responseData)
                        completion(.success(jsonDecoded))
                    } catch {
                        let networkError = NetworkError(message: NetworkResponse.unableToDecode.rawValue)
                        completion(.failure(networkError))
                    }
                case .failure(let message):
                    let networkError = NetworkError(message: message)
                    completion(.failure(networkError))
            }
        }
    }
}
