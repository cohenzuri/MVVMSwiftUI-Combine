//
//  DetailView.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/8/22.
//

import SwiftUI

struct DetailView: View {
    
    let userID: Int
    @StateObject private var vm = DetailViewModel()
    
    var body: some View {
        
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else {
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 18) {
                        
                        Group {
                            generalView
                            linkView
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 18)
                        .background(Theme.background, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                    }
                    .padding()
                }
            }
        }
        
        .navigationTitle("Details")
        
        .task {
            await vm.fetchDetails(for: userID)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(userID: 2)
    }
}

private extension DetailView {
    
    @ViewBuilder
    var generalView: some View {
        
        AsyncImage(url: .init(string: vm.userInfo?.data.avatar ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 130)
                .clipped()
        } placeholder: {
            ProgressView()
        }
        
        VStack(alignment: .leading, spacing: 8) {
            
            PillView(id: vm.userInfo?.data.id ?? 0)
                .padding()
            
            Group {
                firstNameView
                lastNameView
                emailView
            }
            .foregroundColor(Theme.text)
            
            .alert(isPresented: $vm.hasError, error: vm.error) {}
        }
    }
}

private extension DetailView {
    
    var background: some View {
        Theme.background
            .background(ignoresSafeAreaEdges: .top)
    }
    
    @ViewBuilder
    var linkView: some View {
        
        if let supportString = vm.userInfo?.support.url,
           let supportUrl = URL(string: supportString),
           let supportText = vm.userInfo?.support.text
        {
            
            Link(destination: supportUrl) {
                HStack{
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(supportText)
                            .foregroundColor(Theme.text)
                            .font(
                                .system(.body, design: .rounded)
                                .weight(.semibold)
                            )
                        
                            .multilineTextAlignment(.leading)
                        Text(supportString)
                    }
                    Spacer()
                    Symbols.link
                }
            }
        }
    }
}

private extension DetailView {
    
    @ViewBuilder
    var firstNameView: some View {
        
        Text("First Name")
            .foregroundColor(Theme.text)
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.firstName ?? "--")
            .foregroundColor(Theme.text)
            .font(
                .system(.body, design: .rounded)
            )
        Divider()
    }
}

private extension DetailView {
    
    @ViewBuilder
    var lastNameView: some View {
        
        Text("Last Name")
            .foregroundColor(Theme.text)
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.lastName ?? "--")
            .foregroundColor(Theme.text)
            .font(
                .system(.body, design: .rounded)
            )
        Divider()
    }
}

private extension DetailView {
    
    @ViewBuilder
    var emailView: some View {
        
        Text("Email")
            .foregroundColor(Theme.text)
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.email ?? "----")
            .foregroundColor(Theme.text)
            .font(
                .system(.body, design: .rounded)
            )
        
        Divider()
    }
}
