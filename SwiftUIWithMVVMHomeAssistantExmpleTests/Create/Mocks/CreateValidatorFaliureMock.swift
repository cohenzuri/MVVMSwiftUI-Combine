//
//  CreateValidatorFaliurMock.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 2/3/23.
//

import Foundation
@testable import SwiftUIWithMVVMHomeAssistantExmple

struct CreateValidatorFaliureMock: CreateValidatorImap {
    
    func validate(_ user: NewUser) throws { }

}
