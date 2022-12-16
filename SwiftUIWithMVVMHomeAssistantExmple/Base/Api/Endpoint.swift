//
//  Endpoint.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/15/22.
//

import Foundation

enum Endpoint {
    case people
    case detail(is: Int)
    case create(submissionData: Data?)
}

extension Endpoint {
    // https://reqres.in/api/users?page=1
    
    var host: String { "reqres.in" }
    
    var path: String {
        
        switch self {
            
        case .people:
            return "/api/users"
        case .detail(let id):
            return "/api/users\(id)"
        case .create:
            return "/api/users"
        }
    }
    
    var methodType: MethodType {
        switch self {
            
        case .people,
                .detail:
            return .GET
            
        case .create(let data):
            return .POST(data: data)
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
#if DEBUG
        urlComponents.queryItems = [
            URLQueryItem(name: "delay", value: "1")
        ]
#endif
        
        return urlComponents.url
    }
}

extension Endpoint  {
    
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}
