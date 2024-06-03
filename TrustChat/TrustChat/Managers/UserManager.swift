//
//  UserManager.swift
//  BakkalKapindaSatici
//
//  Created by Çağan Durgun on 27.05.2024.
//

/**
 //
 //  UserManager.swift
 //  BakkalKapindaSatici
 //
 //  Created by Çağan Durgun on 27.05.2024.
 //

 import Foundation
 import FirebaseFirestore
 import FirebaseFirestoreSwift
 import FirebaseAuth

 final class UserManager {
     func createNewUser(auth: AuthDataResultModel, name: String?, surname: String?) async throws {
         var userData: [String: Any] = [
             "user_id": auth.uid,
             "created_at": Timestamp(date: Date())
         ]
         
         /// burada var karşı tarafın yeri
         userData["karsi_taraf"] = ""
         
         if let email = auth.email {
             userData["email"] = email
         }
         
         if let name = name {
             userData["name"] = name
         }
         if let surname = surname {
             userData["surname"] = surname
         }

         try await Firestore.firestore().collection("Users").document(auth.uid).setData(userData, merge: false)
     }
     
     func updateUserInfo(userID: String, fieldName: String, newValue: Any) async throws -> Bool {
         let userRef = Firestore.firestore().collection("Users").document(userID)
         
         do {
             // Belirli bir alanı güncelleme
             try await userRef.updateData([fieldName: newValue])
             return true
         } catch {
             // Hata durumunda false döndür
             return false
         }
     }
     
     func deleteUser(auth: AuthDataResultModel) async throws {
         // Firestore'dan kullanıcı verilerini silme
         let userRef = Firestore.firestore().collection("Users").document(auth.uid)
         try await userRef.delete()
         
         // Firebase Authentication'dan kullanıcı hesabını silme
         if let user = Auth.auth().currentUser {
             try await user.delete()
         } else {
             throw NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user signed in"])
         }
     }
     
     func getUser(userID: String) async throws -> UserModelHelper? {
         let document = try await Firestore.firestore().collection("Users").document(userID).getDocument()
         return try document.data(as: UserModelHelper.self)
     }
 }

 */

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

final class UserManager {
   
    private let db = Firestore.firestore()

    func createNewUser(auth: AuthDataResultModel, name: String?, surname: String?) async throws {
        var userData: [String: Any] = [
            "user_id": auth.uid,
            "created_at": Timestamp(date: Date())
        ]
        
        if let email = auth.email {
            userData["email"] = email
        }
        
        if let name = name {
            userData["name"] = name
        }
        
        if let surname = surname {
            userData["surname"] = surname
        }
        
        userData["chats"] = []
        
        try await db.collection("Users").document(auth.uid).setData(userData, merge: false)
    }
    
    func updateUserInfo(userID: String, fieldName: String, newValue: Any, arrayUnion: Bool = false) async throws -> Bool {
        let userRef = db.collection("Users").document(userID)
        
        do {
            if arrayUnion {
                try await userRef.updateData([fieldName: FieldValue.arrayUnion([newValue])])
            } else {
                try await userRef.updateData([fieldName: newValue])
            }
            return true
        } catch {
            // Hata durumunda false döndür
            print("Error updating user info: \(error)")
            return false
        }
    }


    
    func deleteUser(auth: AuthDataResultModel) async throws {
        // Firestore'dan kullanıcı verilerini silme
        let userRef = db.collection("Users").document(auth.uid)
        try await userRef.delete()
        
        // Firebase Authentication'dan kullanıcı hesabını silme
        if let user = Auth.auth().currentUser {
            try await user.delete()
        } else {
            throw NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user signed in"])
        }
    }

    func getUser(userID: String) async throws -> UserModelHelper? {
        let document = try await db.collection("Users").document(userID).getDocument()
        return try document.data(as: UserModelHelper.self)
    }

    func userExists(uid: String, completion: @escaping (Bool) -> Void) {
        let userRef = db.collection("Users").document(uid)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func addresseeExists(email: String, completion: @escaping (Bool) -> Void) {
        let userRef = db.collection("Users").whereField("email", isEqualTo: email)
        userRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let documents = snapshot?.documents, !documents.isEmpty {
                // E-posta adresiyle eşleşen bir kullanıcı bulundu
                completion(true)
            } else {
                // Eşleşen kullanıcı yok
                completion(false)
            }
        }
    }
    
    func getAddressee(email: String, completion: @escaping (UserModelHelper?) -> Void) {
        let userRef = db.collection("Users").whereField("email", isEqualTo: email)
        userRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                // Eşleşen kullanıcı yok
                completion(nil)
                return
            }
            
            // Eşleşen kullanıcı bulundu
            do {
                if let userDocument = documents.first,
                   let user = try? userDocument.data(as: UserModelHelper.self) {
                    completion(user)
                } else {
                    // Kullanıcı verisi alınamadı veya dönüşüm hatası oluştu
                    completion(nil)
                }
            }
        }
    }
    
}
