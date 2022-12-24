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
    @State private var hasAppeared = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                background
            
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        
                        StorysListView()
                            .padding(.horizontal, 30)
                            .environmentObject(vm)
                        
                        LazyVGrid(columns: columns,
                                  spacing: 16) {
                            
                            ForEach(vm.users, id: \.id) { user in
                                
                                NavigationLink {
                                    DetailView(userID: user.id)
                                } label: {
                                    
                                    UserCellView(userData: user)
                                        .task {
                                            if vm.hasReachedEnd(of: user) && !vm.isFetching {
                                                await vm.fetchNextSetOfUsers()
                                            }
                                        }
                                }
                                
                            }
                        }
                                  .padding()
                    }
                    
                    .overlay(alignment: .bottom, content: {
                        if vm.isFetching {
                            ProgressView()
                        }
                    })
                }
            }
            
            .navigationTitle("People")
            
            .toolbar {
               
                ToolbarItem(placement: .primaryAction) {
                    add
                }
                ToolbarItem(placement: .primaryAction) {
                    like
                }
                ToolbarItem(placement: .primaryAction) {
                    send
                }
            }
        }
        
        .task {
            if !hasAppeared {
                await vm.fetchUsers()
                hasAppeared = true
            }
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
    
    var send: some View {
        
        Button {
            Task {
                await vm.fetchUsers()
            }
            
        } label: {
            Symbols.send
                .foregroundColor(.white)
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
        .disabled(vm.isLoading)
    }
    
    var like: some View {
        
        Button {
            
        } label: {
            Symbols.heart
                .foregroundColor(.white)
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    var add: some View {
        
        Button {
            shouldShowCreate.toggle()
        } label: {
            Symbols.plusapp
                .foregroundColor(.white)
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
