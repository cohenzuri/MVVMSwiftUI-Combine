//
//  PeopleView.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/4/22.
//

import SwiftUI

struct UsersListView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @StateObject private var vm = PeopleViewModel()
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        
                        LazyVGrid(columns: columns,
                                  spacing: 16) {
                            
                            ForEach(vm.users, id: \.id) { user in
                                
                                NavigationLink {
                                    DetailView(userID: user.id)
                                } label: {
                                    UserCellView(userData: user)
                                }
                                
                            }
                        }.padding()
                    }
                }
            }
            
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    
                    create
                    
                }
            }
        }
        .task {
            await vm.fetchUsers()
        }
        .sheet(isPresented: $shouldShowCreate) {
            
            CreateView {
                hapric(.success)
                withAnimation(.spring().delay(0.25)) {
                    self.shouldShowSuccess.toggle()
                }
            }
        }
        
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button("Retry") {
                Task {
                   await vm.fetchUsers()
                }
            }
        }
        .overlay {
            if shouldShowSuccess {
                CheckmarkPopoverView()
                    .transition(.scale.combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.spring()) {
                                self.shouldShowSuccess.toggle()
                            }
                        }
                    }
            }
        }
    }
}

//struct PeopleView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UsersListView(users: users.data.first)
//    }
//}


private extension UsersListView {
    
    var create: some View {
        
        Button {
            shouldShowCreate.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
        .disabled(vm.isLoading)
    }
    
    var background: some View {
        
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}
