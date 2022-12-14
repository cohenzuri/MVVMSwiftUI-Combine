//
//  NetworkingManager.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/9/22.
//

import Foundation

// https://reqres.in/api/users?page=1

final class NetworkigManager {
    
    static let shared = NetworkigManager()
    
    private init() {}
    
    func request<T: Codable>(methodType: MethodType = .GET, _ absoluteURL: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url  = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
            
        let request = buildRequest(from: url, methodType: methodType)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("url: \(absoluteURL) response: \(String(describing: response?.description)), error: \(String(describing: error))")
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300 ) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }
        dataTask.resume()
    }
    
    func request(methodType: MethodType = .GET, _ absoluteURL: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let url  = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
            
        let request = buildRequest(from: url, methodType: methodType)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("url: \(absoluteURL) response: \(String(describing: response?.description)), error: \(String(describing: error))")
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300 ) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
           
            completion(.success(()))
        }
        dataTask.resume()
    }
}

extension NetworkigManager {
    
    enum NetworkingError: Error {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkigManager {
    
    enum MethodType {
        case GET
        case POST
    }
}

private extension NetworkigManager {
    
    func buildRequest(from url: URL, methodType: MethodType) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        switch methodType {
         
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
        }
        return request
    }
}
