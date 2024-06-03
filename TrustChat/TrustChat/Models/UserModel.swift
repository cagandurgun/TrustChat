//
//  UserModelTest.swift
//  TrustChat
//
//  Created by Çağan Durgun on 1.06.2024.
//

import Foundation

class UserModel: ObservableObject {
    @Published var user_id: String = ""
    @Published var created_at: Date = Date()
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    
    @Published var chats: [AddresseeModel] = []
   
    
    /// burası diğer kullanıcı tarafından da güncellenebilecek (şimdilik çünkü ilerde istek durumu olacak.)
    func update(with userModelHelper: UserModelHelper) {
        self.user_id = userModelHelper.user_id
        self.email = userModelHelper.email
        self.name = userModelHelper.name
        self.surname = userModelHelper.surname
        self.chats = userModelHelper.chats
    }
}
