//
//  PeopleViewModel.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/4/22.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    
    func fetchUsers() {
        
        DispatchQueue.main.async {
            
            NetworkigManager.shared.request("https://reqres.in/api/users?page=1", type: UsersResponse.self) { [weak self] res in
                
                switch res {
                case .success(let response):
                    self?.users = response.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
