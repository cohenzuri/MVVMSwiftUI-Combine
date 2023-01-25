//
//  PeopleViewModel.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/4/22.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    private var page = 1
    private var totalPages: Int?
    private var networkingManager: NetworkingManagerImpl!
    
    var isLoading: Bool {
        viewState == .loading
    }
   
    var isFetching: Bool {
        viewState == .fetching
    }
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        
        do {
            let response = try await networkingManager.request(session: .shared, .people(page: page), type: UsersResponse.self)
            totalPages = response.totalPages
            users = response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfUsers() async {
        
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        do {
            let response = try await networkingManager.request(session: .shared, .people(page: page), type: UsersResponse.self)
            totalPages = response.totalPages
            users += response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func hasReachedEnd(of user: User) -> Bool {
        return users.last?.id == user.id
    }
}

extension PeopleViewModel {
    
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension PeopleViewModel {
    
    func reset() {
        if viewState == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
    

