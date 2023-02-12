//
//  CreateViewModel.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/13/22.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    @Published var user = NewUser()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    private let validator: CreateValidatorImap!
    private let networkingManager: NetworkingManagerImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared , validator: CreateValidatorImap = CreateValidator()) {
        self.networkingManager = networkingManager
        self.validator = validator
    }
    
    @MainActor
    func create() async {
        
        do {
            try validator.validate(user)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(user)
            
            try await self.networkingManager.request(session: .shared, .create(submissionData: data))
            
            state = .successful
            
        } catch {
            
            self.hasError = true
            self.state = .unsuccessful
            
            switch error {
                
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
                
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
                
            default:
                self.error = .system(error: error)
            }
        }
    }
}

extension CreateViewModel {
    
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}

extension CreateViewModel {
    
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        case system(error: Error)
    }
}

extension CreateViewModel.FormError {
    
    var errorDescription: String? {
        switch self {
        case .networking(error: let err),
                .validation(error: let err):
            return err.errorDescription
        case .system(error: let error):
            return error.localizedDescription
        }
    }
}
