//
//  PersonItemView.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/4/22.
//

import SwiftUI

struct UserCellView: View {
    
    let userData: User
    
    var body: some View {
        
        VStack(spacing: .zero) {
            
            AsyncImage(url: .init(string: userData.avatar)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                ProgressView()
            }

            VStack {
                
                PillView(id: userData.id)
                
                Text("\(userData.firstName ?? "") \(userData.lastName ?? "")")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.body, design: .rounded)
                    )
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5) // TODO: all the magic numbers to constants
            //.background(Theme.detailBackground)
            .background(.white) // TODO: add the rigth color
        }
        
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        
        .shadow(color: Theme.text.opacity(0.5),
                radius: 2,
                x: 0,
                y: 1)
    }
}


//struct PersonItemView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        UserCellView(user: previewUser)
//            .frame(width: 250)
//    }
//}

