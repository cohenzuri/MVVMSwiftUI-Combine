//
//  NetworkingManagerUserDetailsResponseFailureMock.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 1/25/23.
//

import Foundation
import SwiftUIWithMVVMHomeAssistantExmple

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {}
}

