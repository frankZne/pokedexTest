//
//  ApiCall.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import Foundation

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

class ApiCall {
    static public var shared = ApiCall()
    private let urlSession = URLSession.shared
    
    func fetchResources<T: Decodable>(url: URL, queryParameters: [String: String]? = nil, completion: (@escaping (Result<T, APIServiceError>) -> Void)) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        
        if let queryParameters = queryParameters {
            urlComponents.queryItems?.append(contentsOf: queryParameters.map { URLQueryItem(name: $0, value: $1) })
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if let data = data, let response = response {
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                do {
                    _ = String(data: data, encoding: .utf8)
                    let values = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    print(error)

                        
          
                    
                    completion(.failure(.decodeError))
                }
            }
            if error != nil {
                completion(.failure(.apiError))
            }
        }.resume()
    }
    
}
