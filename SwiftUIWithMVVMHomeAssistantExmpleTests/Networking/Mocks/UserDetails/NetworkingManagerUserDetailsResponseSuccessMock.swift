//
//  NetworkingManagerUserDetailsResponseSuccess.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 1/25/23.
//

import Foundation
import SwiftUIWithMVVMHomeAssistantExmple

class NetworkingManagerUserDetailsResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "SingleUserData", type: UserResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {}
}
