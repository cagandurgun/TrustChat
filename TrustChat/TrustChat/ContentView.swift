//
//  ContentView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 30.05.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewSelecterModel: ViewSelecterModel
    @StateObject var userModel = UserModel()
    let authManager: AuthManager
    let userManager: UserManager
    
    var body: some View {
        ViewToggler(authManager: authManager, userManager: userManager)
            .environmentObject(viewSelecterModel)
            .environmentObject(userModel)
            .onAppear(perform: loadUserData)
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
                        /// Kullanıcı verisi bulunamadı
                    }
                } else {
                    /// Kullanıcı oturumu açılmamış
                }
            } catch {
                /// Hata durumu
            }
        }
    }
}
