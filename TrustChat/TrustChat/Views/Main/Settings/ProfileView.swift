//
//  ProfileView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 30.05.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userModel: UserModel
    // buradan şeyi sildik.
    
    let authManager: AuthManager
    let userManager: UserManager
    
    
    var body: some View {
        VStack {
            Text("Ad: \(userModel.name)")
            Text("Soyad: \(userModel.surname)")
            Text("E-posta: \(userModel.email)")
            /// bu kısım değişmeli
            /// Text("Konusulan: \(userModel.karsi_taraf)")
        }
        .onAppear {
            loadUserData()
        }
    }
    
    private func loadUserData() {
        Task {
            do {
                if let authUser = authManager.getAuthUser() {
                    if let user = try await userManager.getUser(userID: authUser.uid) {
                        DispatchQueue.main.async {
                            userModel.update(with: user)
                        }
                    } else {
                        // Kullanıcı verisi bulunamadı
                        print("kullanıcı verisi1")
                    }
                } else {
                    // Kullanıcı oturumu açılmamış
                    print("kullanıcı verisi2")
                }
            } catch {
                // Hata durumu
                print("kullanıcı verisi3")
            }
        }
    }
    
}
