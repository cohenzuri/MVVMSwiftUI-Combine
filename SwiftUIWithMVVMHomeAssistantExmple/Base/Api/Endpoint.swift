//
//  Endpoint.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/15/22.
//

import Foundation

enum Endpoint {
    case people(page: Int)
    case detail(is: Int)
    case create(submissionData: Data?)
}

extension Endpoint {

    var host: String { "reqres.in" }
    
    var path: String {
        
        switch self {
            
        case .people:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
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
    
    var queryItems: [String: String]? {
        
        switch self {
            
        case .people(page: let page):
            return ["page":"\(page)"]
            
        default:
            return nil
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItem = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
#if DEBUG
        requestQueryItem?.append(URLQueryItem(name: "delay", value: "1"))
#endif
        
        urlComponents.queryItems = requestQueryItem
        return urlComponents.url
    }
}

extension Endpoint  {
    
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}
