//
//  NetworkingEndpointTest.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 12/20/22.
//

import XCTest

@testable import SwiftUIWithMVVMHomeAssistantExmple

final class NetworkingEndpointTest: XCTestCase {
    
    func test_with_user_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.people(page: 1)
        
        let expectedHost = "reqres.in"
        let actualHost = endpoint.host
        
        XCTAssertEqual(expectedHost, actualHost , "The host should be \(expectedHost)")
        
        let expectedPath = "/api/users"
        let actualPath = endpoint.path
        
        XCTAssertEqual(expectedPath, actualPath, "The path should be \(expectedPath))")
        
        let expectedType: Endpoint.MethodType = .GET
        let actualType = endpoint.methodType
        
        XCTAssertEqual(expectedType, actualType, "The method type should be \(expectedType))")
        
        let expectedItem = ["page": "1"]
        let actualItem = endpoint.queryItems
        
        XCTAssertEqual(expectedItem, actualItem, "The query item should be \(expectedItem)")
        
        let expectedUrl = URL(string: "https://reqres.in/api/users?page=1&delay=2")
        let actualUrl = endpoint.url?.absoluteURL
        
        XCTAssertEqual( expectedUrl, actualUrl, "The generated dosen't motch our endpoint should be\(expectedUrl)")
    }
    
    func test_with_detail_endpoint_request_is_valid() {
        
        let userId = 1
        let endpoint = Endpoint.detail(is: userId)
        
        let expectedHost = "reqres.in"
        let actualHost = endpoint.host
        
        XCTAssertEqual(expectedHost, actualHost , "The host should be \(expectedHost)")
        
        let expectedPath = "/api/users/\(userId)"
        let actualPath = endpoint.path
        
        XCTAssertEqual(expectedPath, actualPath, "The path should be \(expectedPath))")
        
        let expectedType: Endpoint.MethodType = .GET
        let actualType = endpoint.methodType
        
        XCTAssertEqual(expectedType, actualType, "The method type should be \(expectedType))")
        
        XCTAssertNil(endpoint.queryItems)
        
        let expectedUrl = URL(string: "https://reqres.in/api/users/\(userId)?delay=2")
        let actualUrl = endpoint.url?.absoluteURL
        
        XCTAssertEqual(expectedUrl, actualUrl, "The generated dosen't motch our endpoint should be\(expectedUrl)")
    }
    
    func test_with_create_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.create(submissionData: nil)
        
        let expectedHost = "reqres.in"
        let actualHost = endpoint.host
        
        XCTAssertEqual(actualHost, actualHost, "The host should be \(expectedHost)")
        
        let expectedPath = "/api/users"
        let actualPath = endpoint.path
        
        XCTAssertEqual(expectedPath, actualPath, "The path should be \(expectedPath)")
        
        let expectedType: Endpoint.MethodType = .POST(data: nil)
        let actualType = endpoint.methodType
        
        XCTAssertEqual(expectedType, actualType, "The method type should be \(expectedType))")
        
        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
        
        let expectedUrl = URL(string: "https://reqres.in/api/users?delay=2")
        let actualUrl = endpoint.url?.absoluteURL
        
        XCTAssertEqual(expectedUrl, actualUrl, "The generated dosen't motch our endpoint should be\(expectedUrl)")
    }
}
