//
//  PeopleViewModel.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/4/22.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkigManager.NetworkingError?
    @Published var hasError = false
    @Published private(set) var isLoading = false
    
    @MainActor
    func fetchUsers() async {
        
        self.isLoading = true
        
        defer { self.isLoading = false }
        
        do {
            let response = try await NetworkigManager.shared.request(.people, type: UsersResponse.self)
            users = response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkigManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
        
}

    

