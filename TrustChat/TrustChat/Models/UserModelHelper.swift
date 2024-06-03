//
//  UserModel.swift
//  TrustChat
//
//  Created by Çağan Durgun on 31.05.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModelHelper: Codable {
    let user_id: String
    let created_at: Date
    let email: String
    let name: String
    let surname: String
    let chats: [AddresseeModel]
}
