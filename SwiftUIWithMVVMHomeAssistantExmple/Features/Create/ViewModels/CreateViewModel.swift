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
    
    private let validator = CreateValidator()
    
    func create() {
        
        do {
            try validator.validate(user)
            
            self.state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(user)
            
            NetworkigManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users?delay=3") { [weak self] res in
                
                DispatchQueue.main.async {
                    
                    switch res {
                        
                    case .success:
                        self?.state = .successful
                    case .failure(let err):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        
                        if let networkingError = err as? NetworkigManager.NetworkingError {
                            self?.error = .networking(error: networkingError)
                        }
                    }
                }
            }
            
        } catch {
            
            self.hasError = true
            if let validationError = error as? CreateValidator.CreateValidatorError {
                self.error = .validation(error: validationError)
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
    }
}

extension CreateViewModel.FormError {
    
    var errorDescription: String? {
        switch self {
        case .networking(error: let err),
                .validation(error: let err):
            return err.errorDescription
        }
    }
}
