//
//  AuthManager.swift
//  BakkalKapindaSatici
//
//  Created by Çağan Durgun on 27.05.2024.
//

import Foundation
import FirebaseAuth

/// gerekli video https://youtu.be/jlC1yjVTMtA?si=UPkca4j1zae6-ADJ reseting pasword vb işlemler...
final class AuthManager {
    private let auth: Auth
    
    init(auth: Auth = Auth.auth()) {
        self.auth = auth
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResults = try await auth.createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResults.user)
    }
    
    func getAuthUser() -> AuthDataResultModel? {
        if let user = Auth.auth().currentUser {
            return AuthDataResultModel(user: user)
        } else {
            return nil
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await auth.signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func deleteAccount() async throws {
        guard let user = auth.currentUser else { return }
        try await user.delete()
    }
}
