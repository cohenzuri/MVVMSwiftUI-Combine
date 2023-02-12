//
//  CreateValidatorSuccessMock.swift
//  SwiftUIWithMVVMHomeAssistantExmpleTests
//
//  Created by zuri cohen on 2/3/23.
//

import Foundation
@testable import SwiftUIWithMVVMHomeAssistantExmple

struct CreateValidatorSuccessMock: CreateValidatorImap {
    
    func validate(_ user: NewUser) throws { }
}
