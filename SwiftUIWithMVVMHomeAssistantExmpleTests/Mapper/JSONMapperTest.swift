//
//  JSONMapperTest.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 12/17/22.
//

import XCTest
@testable import SwiftUIWithMVVMHomeAssistantExmple

class JSONMapperTests: XCTestCase {
    
    func test_with_valid_json_successfully_decoded() {
        
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self), "Mapper shouldn't throw an error")
        
        let userResponse = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        
        XCTAssertNotNil(userResponse, "User response sholdn't be nil")
        
        XCTAssertEqual(userResponse?.page, 1, "Page number should be 1")
        XCTAssertEqual(userResponse?.perPage, 6, "Page number should be 6")
        XCTAssertEqual(userResponse?.total, 12, "Total should be 12")
        XCTAssertEqual(userResponse?.totalPages, 2, "Total pages should be 2")
    }
    
    func test_with_missing_file_error_thrown() {
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "An error should be thrown")
        
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
        } catch {
            
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing file")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_file_error_thrown() {
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "dadfsg", type: UsersResponse.self), "An error should be thrown")
        
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
        } catch {
            
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing file")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_json_error_thrown() {
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "UsersStaticData", type: UserResponse.self), "Mapper should throw")
        
        do {
            _ = try StaticJSONMapper.decode(file: "UsersStaticData", type: UserResponse.self)
        } catch {
            if error is StaticJSONMapper.MappingError {
                XCTFail("Got the wrong type of error, expecting a system decoding error")
            }
        }
    }
    
    
    
}

