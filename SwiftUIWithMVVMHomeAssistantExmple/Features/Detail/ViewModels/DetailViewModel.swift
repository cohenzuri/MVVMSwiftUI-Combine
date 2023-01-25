//
//  DetailViewModel.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/11/22.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    @Published private(set) var isLoading = false
    
    private let networingManager: NetworkingManagerImpl!
    
    init(networingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networingManager = networingManager
    }
    
    @MainActor
    func fetchDetails(for userId: Int) async {
        
        self.isLoading = true
        
        defer { self.isLoading = false }
        
        do {
            let response = try await networingManager.request(session: .shared,
                                                              .detail(is: userId), type: UserResponse.self)
            self.userInfo = response
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
