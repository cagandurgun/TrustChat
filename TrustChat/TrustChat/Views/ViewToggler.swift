//
//  ViewToggler.swift
//  BakkalKapindaSatici
//
//  Created by Çağan Durgun on 27.05.2024.
//

import SwiftUI

struct ViewToggler: View {
    @EnvironmentObject var viewSelecterModel: ViewSelecterModel
    @EnvironmentObject var userModel: UserModel
    let authManager: AuthManager
    let userManager: UserManager
    
    var body: some View {
        VStack {
            if viewSelecterModel.selectedScreen == "LoginView" {
                LoginView(authManager: authManager, userManager: userManager)
                    .environmentObject(viewSelecterModel)
            } else if viewSelecterModel.selectedScreen == "AppView" {
                MainView(authManager: authManager, userManager: userManager)
                    .environmentObject(viewSelecterModel)
            }
        }
        .onAppear {
            if let authUser = authManager.getAuthUser() {
                userManager.userExists(uid: authUser.uid) { userExists in
                    if userExists {
                        viewSelecterModel.selectedScreen = "AppView"
                    } else {
                        viewSelecterModel.selectedScreen = "LoginView"
                    }
                }
            } else {
                viewSelecterModel.selectedScreen = "LoginView"
            }
        }
    }
}
