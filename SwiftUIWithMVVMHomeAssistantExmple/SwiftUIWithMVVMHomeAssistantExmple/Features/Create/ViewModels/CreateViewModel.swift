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
    
    func create() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(user)
        
        NetworkigManager.shared.request(methodType: .POST,  "https://reqres.in/api/users") { [weak self] res in
            
            DispatchQueue.main.async {
                
                switch res {
                    
                case .success:
                    self?.state = .successful
                case .failure(let err):
                    self?.state = .unsuccessful
                    break
                }
            }
        }
    }
}

extension CreateViewModel {
    
    enum SubmissionState {
        case unsuccessful
        case successful
    }
}
