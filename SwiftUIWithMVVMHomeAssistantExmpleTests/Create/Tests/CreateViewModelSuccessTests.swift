//
//  CreateViewModelSuccessTest.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 2/3/23.
//

import XCTest
@testable import SwiftUIWithMVVMHomeAssistantExmple

class CreateViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var validatorMock: CreateValidatorImap!
    private var createVM: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validatorMock = CreateValidatorSuccessMock()
        createVM = CreateViewModel(networkingManager: networkingMock, validator: validatorMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validatorMock = nil
        createVM = nil
    }
    
    func test_with_successful_response_submission_state_is_successful() async throws {

        XCTAssertNil(createVM.state, "The view model state should be nil initially")
        
        defer { XCTAssertEqual(createVM.state, .successful, "The view model state should be successful") }
        
        await createVM.create()
    }
}
