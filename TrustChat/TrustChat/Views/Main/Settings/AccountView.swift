//
//  AccountView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 30.05.2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewSelecterModel: ViewSelecterModel
    @EnvironmentObject var userModel: UserModel
    let authManager: AuthManager
    let userManager: UserManager
    
    
    @State private var showAlert = false
    @State private var karsi_taraf_email = ""
    
    var body: some View {
        VStack {
            
            /*
             
                 VStack {
                     TextField("", text: $karsi_taraf_email)
                     
                     Button(action: {
                         Task {
                             await addKarsiTaraf()
                         }
                     }, label: {
                         Text("Ekle")
                     })
                 }
             */
            
            VStack {
                Button(action: {
                    /// hesap silinsin mi?
                    showAlert = true
                }, label: {
                    HStack {
                        Text("Delete account!")
                            .foregroundColor(.red)
                        Spacer()
                    }
                    .padding(.vertical, 5)
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Delete Account"),
                        message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                        primaryButton: .destructive(Text("Delete")) {
                            deleteAccount()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding()
            .background(Color.secondary.gradient.opacity(0.3))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
        }
        .padding()
    }
    
    /// Karşı tarafı eklemek için geçici fonksiyon
    /// Database güncelleniyor ama user model güncellenmiyor
    /// bu kısım değişmeli
    /*
     func addKarsiTaraf() async {
         do {
             /// bu sayede modeli de güncelleyelim
             let updateSuccessful = try await userManager.updateUserInfo(userID: userModel.user_id, fieldName: "karsi_taraf", newValue: karsi_taraf_email)
             
             if updateSuccessful {
                 userModel.karsi_taraf = karsi_taraf_email
             }
         } catch {
             // Hata işleme kodu burada
             print("Hata oluştu: \(error)")
         }
     }
     */

    /// hesap silme işlemleri
    func deleteAccount() {
        Task {
            do {
                if let currentUser = authManager.getAuthUser() {
                    viewSelecterModel.selectedScreen = "LoginView"
                    try await authManager.deleteAccount()
                    try await userManager.deleteUser(auth: currentUser)
                }
            } catch {
                
            }
        }
    }
}
