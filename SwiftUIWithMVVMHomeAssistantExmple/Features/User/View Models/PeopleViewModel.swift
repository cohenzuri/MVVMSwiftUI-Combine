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
    
    func fetchUsers() {
        
        DispatchQueue.main.async {
            
            self.isLoading = true
            
            NetworkigManager.shared.request("https://reqres.in/api/users?delay=0", type: UsersResponse.self) { [weak self] res in
                defer { self?.isLoading = false }
                switch res {
                case .success(let response):
                    self?.users = response.data
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkigManager.NetworkingError
                }
            }
        }
    }
}
