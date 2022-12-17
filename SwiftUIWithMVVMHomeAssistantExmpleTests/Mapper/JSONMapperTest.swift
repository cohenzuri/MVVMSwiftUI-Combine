//
//  JSONMapperTest.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 12/17/22.
//

import Foundation
import XCTest
@testable import SwiftUIWithMVVMHomeAssistantExmple

class JSONMapperTests: XCTestCase {
    
    func test_with_valid_json_successfully_decoded() {
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "")
        XCTFail()
    }
    
    func test_with_missing_file_error_thrown() {
        XCTFail()
    }
    
    func test_with_invalid_json_error_thrown() {
        XCTFail()
    }
    
}
