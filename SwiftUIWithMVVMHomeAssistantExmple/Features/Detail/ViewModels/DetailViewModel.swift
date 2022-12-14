//
//  DetailViewModel.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/11/22.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserResponse?
    @Published private(set) var error: NetworkigManager.NetworkingError?
    @Published var hasError = false
    
    func fetchDetails(for userId: Int) {
        
        DispatchQueue.main.async {
            
            NetworkigManager.shared.request("https://reqres.in/api/users/\(userId)", type: UserResponse.self) { [weak self] res in
                
                switch res {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkigManager.NetworkingError
                }
            }
        }
    }
}
