//
//  NetworkingManagerCreateSuccessMock.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 2/9/23.
//

import Foundation

import Foundation
@testable import SwiftUIWithMVVMHomeAssistantExmple

struct NetworkingManagerCreateSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws { }
       
}
