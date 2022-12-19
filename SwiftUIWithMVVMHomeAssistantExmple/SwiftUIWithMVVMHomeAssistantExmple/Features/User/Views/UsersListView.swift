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
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                background
                
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
            
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    
                    create
                    
                }
            }
        }
        .onAppear {
            vm.fetchUsers()
        }
        .sheet(isPresented: $shouldShowCreate) {
            CreateView()
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
            Symboles.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    var background: some View {
        
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}
