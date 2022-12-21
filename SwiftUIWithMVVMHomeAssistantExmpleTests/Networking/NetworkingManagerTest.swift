//
//  NetworkingManagerTest.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 12/21/22.
//

import XCTest

final class NetworkingManagerTest: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://reqres.in/users")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }

    func test_with_successful_response_response_is_valid() async throws {
        
    }
    
    func test_with_successful_response_void_is_valid() async throws {
        
    }
    
    func test_with_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
    }
    
    func test_with_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
    }
    
    func test_with_successful_response_with_invalid_json_is_invalid() async {
        
        
    }

}
