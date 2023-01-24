//
//  StorysListView.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/24/22.
//

import SwiftUI

struct StorysListView: View {
    
    @EnvironmentObject var vm: PeopleViewModel
    
    let rows = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: true) {
            
            HStack(spacing: 10) {
                
                ForEach(vm.users, id: \.id) { user in
                
                    VStack {
                        
                        AsyncImage(url: URL(string: user.avatar))
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(LinearGradient(colors: [.red ,.orange, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.3)
                            )
                            .frame(width: 68, height: 68)
                            .padding(.top, 10)
    
                        
                        Text("\(user.firstName!) \(user.lastName!)")
                            .foregroundColor(.white)
                        
                    }
                    .background(Color.black)
                }
            }
        }
    }
}

struct StorysListView_Previews: PreviewProvider {
    static var previews: some View {
        StorysListView()
    }
}
