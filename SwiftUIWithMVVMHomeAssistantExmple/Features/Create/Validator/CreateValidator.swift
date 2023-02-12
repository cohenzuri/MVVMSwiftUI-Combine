//
//  CreateValidator.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/15/22.
//

import Foundation

protocol CreateValidatorImap {
    
    func validate(_ user: NewUser) throws
}

struct CreateValidator: CreateValidatorImap {
  
    func validate(_ user: NewUser) throws {
        
        if user.firstName.isEmpty {
            throw CreateValidatorError.invalidFirstName
        }
        
        if user.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
        }
        
        if user.job.isEmpty {
            throw CreateValidatorError.invalidJob
        }
    }
}

extension CreateValidator {
    
    enum CreateValidatorError: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidJob
    }
}

extension CreateValidator.CreateValidatorError {
    
    var errorDescription: String? {
        
        switch self {
        case .invalidFirstName:
            return "Fist name can't be empy"
        case .invalidLastName:
            return "Last name can't be empy"
        case .invalidJob:
            return "Job can't be empy"
        }
    }
}
