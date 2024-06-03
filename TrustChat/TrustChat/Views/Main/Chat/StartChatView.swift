//
//  StartChatView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 31.05.2024.
//

import SwiftUI
import CoreNFC

/**
 //
 //  StartChatView.swift
 //  TrustChat
 //
 //  Created by Çağan Durgun on 31.05.2024.
 //

 import SwiftUI
 import CoreNFC

 /// bu ekranda kullanıcı aranacak ve eklenecektir.
 /// bir adet search olacak.
 /// bir kullanıcı diğerini search ettiğinde ve sohbet başlattığında otomatik olarak diğer kullanıcıda da başlamalı.
 /// bu özellik sonradan istek şeklinde yapılabilir.
 /// yani databasede sohbetler diye bir bölüm olsun
 /// bu sohbetlerin içinde kullanıcılar olsun.
 /// bu kullanıcıların içinde mesajlar olsun.

 /**
  Bu sınıf içine geçilecek parametreler belli değil.
  */
 /**
  Burada bir değişken olacak (güvenli olmalı) bu aktif edilmeden chat view a geçilemez.
  yani ikili konuşmanın başlatılması bu şekilde sağlanacaktır. Ya NFC ya da manuel olarak
  eşleşme yapılabilir.
  */
 struct StartChatView: View {
     @EnvironmentObject var userModel: UserModel
     
     @State private var addressee: String = ""
     @State private var addresseeFound: Bool = false
     let userManager: UserManager
     
     @State private var addresseeModel: UserModelHelper?
     
     var body: some View {
         
         
         VStack {
             /// kullanıcı var mı ara
             /// varsa bilgilerini alarak kendi chatsine ekle
             /// kendi bilgilerini vererek onun chatsine eklen.
             TextField("", text: $addressee)
                 .padding()
                 .background(Color.gray)
             
             Button(action: {
                 searchUser()
             }, label: {
                 Text("search")
             })
             
             if addresseeFound {
                 HStack {
                     Text("username")
                     Button(action: {
                         /// burada kullanıcıyı ekleme işlemleri yapılsın
                         Task {
                             if let addresseeHelper = addresseeModel {
                                 // UserModelHelper tipindeki değeri AddresseeModel'e dönüştür
                                 let addresseeModel = AddresseeModel(email: addresseeHelper.email, name: addresseeHelper.name, chatHistory: [])
                                 await addChat(userModel: userModel, addresseeModel: addresseeModel)
                             }

                         }
                     }, label: {
                         Text("Ekle")
                     })
                 }
             }
         }
     }
     
     func searchUser() {
         userManager.getAddressee(email: addressee) { user in

              if let user = user {
                  print("Eşleşen kullanıcı bulundu: \(user)")
                  addresseeFound = true
                  addresseeModel = user
              } else {
                  addresseeFound = false
                  addresseeModel = nil
                  print("Eşleşen kullanıcı bulunamadı.")
              }
         }
     }
     
     func addChat(userModel: UserModel, addresseeModel: AddresseeModel) async {
         
         do {
             let userChatData = try addresseeModel.toDictionary()
             let addresseeChatData = try AddresseeModel(email: userModel.email, name: userModel.name, chatHistory: []).toDictionary()
             
             _ = try await userManager.updateUserInfo(userID: userModel.user_id, fieldName: "chats", newValue: userChatData, arrayUnion: true)
             _ = try await userManager.updateUserInfo(userID: addresseeModel.email, fieldName: "chats", newValue: addresseeChatData, arrayUnion: true)
         } catch {
             // Hata işleme kodu buraya gelecek
             print("Hata oluştu: \(error)")
         }
     }


     
     
     
 }

 extension Encodable {
     func toDictionary() throws -> [String: Any] {
         let data = try JSONEncoder().encode(self)
         let json = try JSONSerialization.jsonObject(with: data, options: [])
         guard let dictionary = json as? [String: Any] else {
             throw NSError()
         }
         return dictionary
     }
 }

 */

/// bu ekranda kullanıcı aranacak ve eklenecektir.
/// bir adet search olacak.
/// bir kullanıcı diğerini search ettiğinde ve sohbet başlattığında otomatik olarak diğer kullanıcıda da başlamalı.
/// bu özellik sonradan istek şeklinde yapılabilir.
/// yani databasede sohbetler diye bir bölüm olsun
/// bu sohbetlerin içinde kullanıcılar olsun.
/// bu kullanıcıların içinde mesajlar olsun.

/**
 Bu sınıf içine geçilecek parametreler belli değil.
 */
/**
 Burada bir değişken olacak (güvenli olmalı) bu aktif edilmeden chat view a geçilemez.
 yani ikili konuşmanın başlatılması bu şekilde sağlanacaktır. Ya NFC ya da manuel olarak
 eşleşme yapılabilir.
 */
struct StartChatView: View {
    @EnvironmentObject var userModel: UserModel
    
    @State private var addressee: String = ""
    @State private var addresseeFound: Bool = false
    let userManager: UserManager
    
    @State private var addresseeModel: UserModelHelper?
    
    var body: some View {
        
        
        VStack {
            TextField("", text: $addressee)
                .padding()
                .background(Color.gray)
            
            Button(action: {
                searchUser()
            }, label: {
                Text("search")
            })
            
            if addresseeFound {
                HStack {
                    Text("username")
                    Button(action: {
                        /// burada kullanıcıyı ekleme işlemleri yapılsın
                        Task {
                            await addChat()
                        }
                    }, label: {
                        Text("Ekle")
                    })
                }
            }
        }
    }
    
    func searchUser() {
        userManager.getAddressee(email: addressee) { user in

             if let user = user {
                 print("Eşleşen kullanıcı bulundu: \(user)")
                 addresseeFound = true
                 addresseeModel = user
             } else {
                 addresseeFound = false
                 addresseeModel = nil
                 print("Eşleşen kullanıcı bulunamadı.")
             }
        }
    }
    
    func addChat() async {
        
        do {
            let userChatData = try AddresseeModel(email: addresseeModel?.email ?? "", name: addresseeModel?.name ?? "", chatHistory: []).toDictionary()
            let addresseeChatData = try AddresseeModel(email: userModel.email, name: userModel.name, chatHistory: []).toDictionary()
            
            
            /// for user
            _ = try await userManager.updateUserInfo(userID: userModel.user_id, fieldName: "chats", newValue: userChatData, arrayUnion: true)
            /// for karşı taraf
            _ = try await userManager.updateUserInfo(userID: addresseeModel?.user_id ?? "", fieldName: "chats", newValue: addresseeChatData, arrayUnion: true)
        } catch {
            // Hata işleme kodu buraya gelecek
            print("Hata oluştu: \(error)")
        }
    }
}

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        guard let dictionary = json as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
