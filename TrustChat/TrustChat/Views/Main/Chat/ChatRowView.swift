//
//  ChatRowView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 2.06.2024.
//

import SwiftUI

struct ChatRowView: View {
    @EnvironmentObject var userModel: UserModel
    var addresseeModel: AddresseeModel
    
    var body: some View {
        VStack {
            NavigationLink(destination: MessagesView(addressee: addresseeModel).environmentObject(userModel)) {
                HStack {
                    Image(systemName: "message")
                        .foregroundColor(.primary)
                    Text(addresseeModel.name)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 5)
            }
        }
        .padding()
        .background(Color.gray.gradient.opacity(0.3))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
}

