//
//  CreateFormValidatorTest.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/19/22.
//


import XCTest
@testable import SwiftUIWithMVVMHomeAssistantExmple

final class CreateFormValidatorTest: XCTestCase {
    
    private var createValidator: CreateValidator!
    
    override func setUp() {
        createValidator = CreateValidator()
    }
    
    override func tearDown() {
        createValidator = nil
    }
    
    func test_with_empty_person_first_name_error_thrown() {
        
        let user = NewUser()
        
        XCTAssertThrowsError(try createValidator.validate(user), "Error for an empty first name should be thrown")
        
        do {
            _ = try createValidator.validate(user)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError
                .invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_first_name_error_thrown() {
        
        let user = NewUser(lastName: "AA", job: "iOS dev")
        
        XCTAssertThrowsError(try createValidator.validate(user), "Error for an empty first name should be thrown")
        
        do {
            _ = try createValidator.validate(user)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError
                .invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_last_name_error_thrown() {
        
        let user = NewUser(firstName: "AA", job: "iOS dev")
        
        XCTAssertThrowsError(try createValidator.validate(user), "Error for an empty last name should be thrown")
        
        do {
            _ = try createValidator.validate(user)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError
                .invalidLastName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_job_error_thrown() {
        
        let user = NewUser(firstName: "AA", lastName: "Cohen")
        
        XCTAssertThrowsError(try createValidator.validate(user), "Error for an empty job  should be thrown")
        
        do {
            _ = try createValidator.validate(user)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError
                .invalidJob, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_valid_person_error_not_thrown() {
        
        let user = NewUser(firstName: "AA", lastName: "Cohen", job: "iOS dev")
        
        do {
            _ = try createValidator.validate(user)
        } catch {
            XCTFail("No errors should be thrown, since the person should be a valid object")
        }
    }
}

