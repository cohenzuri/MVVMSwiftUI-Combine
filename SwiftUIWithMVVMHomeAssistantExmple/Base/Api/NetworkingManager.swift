//
//  NetworkingManager.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/9/22.
//

import Foundation

// https://reqres.in/api/users?page=1

// https://reqres.in/api/users/1?delay=2

final class NetworkigManager {
    
    static let shared = NetworkigManager()
    
    private init() {}
    
    func request<T: Codable>(_ endpoint: Endpoint, type: T.Type)  async throws -> T {
        
        guard let url  = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300 ) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        
        return res
    }
    
    func request(_ endpoint: Endpoint) async throws -> Void {
        
        guard let url  = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300 ) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
}

extension NetworkigManager {
    
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkigManager.NetworkingError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .invalidUrl:
            return "URL isn't valid"
        case .custom(error: let error):
            return "Something went wrong \(error.localizedDescription)"
        case .invalidStatusCode(statusCode: let statusCode):
            return "Status code faliled to wrong range"
        case .invalidData:
            return "Rsponse data is invalid"
        case .failedToDecode(error: let error):
            return "Failed to decode"
        }
    }
}

private extension NetworkigManager {
    
    func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        
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
