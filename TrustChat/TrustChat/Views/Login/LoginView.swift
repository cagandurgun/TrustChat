//
//  LoginView.swift
//  BakkalKapindaSatici
//
//  Created by Çağan Durgun on 27.05.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewSelecterModel: ViewSelecterModel
    let authManager: AuthManager
    let userManager: UserManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var ad: String = ""
    @State private var soyad: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("TrustChat")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                TextField("Ad", text: $ad)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
                
                TextField("Soyad", text: $soyad)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            }
            
            TextField("E-posta", text: $email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .keyboardType(.emailAddress)

            SecureField("Şifre", text: $password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)

            Button(action: signIn) {
                Text("Giriş Yap")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .padding()
    }
    
    
    func signIn() {
        Task {
            // İsim ve soyisim kontrolü
            guard !ad.isEmpty, !soyad.isEmpty else {
                errorMessage = "Lütfen ad ve soyadınızı girin."
                return
            }

            do {
                let authDataResult = try await authManager.createUser(email: email, password: password)
                // Giriş başarılı, kullanıcı verilerini kaydetme
                try await userManager.createNewUser(auth: authDataResult, name: ad, surname: soyad)
                viewSelecterModel.selectedScreen = "AppView"
            } catch {
                errorMessage = error.localizedDescription
                if errorMessage == "The email address is already in use by another account." {
                    do {
                        _ = try await authManager.signIn(email: email, password: password)
                        // Giriş başarılı
                        viewSelecterModel.selectedScreen = "AppView"
                    } catch {
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}
