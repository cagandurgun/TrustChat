//
//  SettingsView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 30.05.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewSelecterModel: ViewSelecterModel
    @EnvironmentObject var userModel: UserModel
    let authManager: AuthManager
    let userManager: UserManager
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack {
                        NavigationLink(destination: ChatView(userManager: userManager, authManager: authManager).environmentObject(userModel)) {
                            HStack {
                                Image(systemName: "message")
                                    .foregroundColor(.primary)
                                Text("Chat")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color.secondary.gradient.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    
                    HStack {
                        Text("Settings")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    
                    VStack {
                        NavigationLink(destination: ProfileView(authManager: authManager, userManager: userManager)
                            .environmentObject(userModel)) {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .foregroundColor(.primary)
                                Text("Profile")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: AccountView(authManager: authManager, userManager: userManager)
                            .environmentObject(viewSelecterModel)
                            .environmentObject(userModel)) {
                            HStack {
                                Image(systemName: "key")
                                    .foregroundColor(.primary)
                                Text("Account")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color.secondary.gradient.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    
                    VStack {
                        NavigationLink(destination: SecurityView()) {
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.primary)
                                Text("Security")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: NotificationView()) {
                            HStack {
                                Image(systemName: "app.badge")
                                    .foregroundColor(.primary)
                                Text("Notification")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: PaymentView()) {
                            HStack {
                                Image(systemName: "creditcard")
                                    .foregroundColor(.primary)
                                Text("Payment")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color.secondary.gradient.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .padding(.vertical)
                    
                    VStack {
                        NavigationLink(destination: ThemeView()) {
                            HStack {
                                Image(systemName: "paintpalette")
                                    .foregroundColor(.primary)
                                Text("Theme")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: LanguageView()) {
                            HStack {
                                Image(systemName: "person.wave.2")
                                    .foregroundColor(.primary)
                                Text("Language")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: FeaturesView()) {
                            HStack {
                                Image(systemName: "questionmark")
                                    .foregroundColor(.primary)
                                Text("Features")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color.secondary.gradient.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    
                    VStack {
                        Button(action: {
                            if let url = URL(string: "https://cagandurgun.pythonanywhere.com/TrustChat") {
                                UIApplication.shared.open(url)
                            }
                        }, label: {
                            HStack {
                                Image(systemName: "macwindow")
                                    .foregroundColor(.primary)
                                Text("Website")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        })
                    }
                    .padding()
                    .background(Color.secondary.gradient.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .padding(.vertical)
                    
                    VStack {
                        NavigationLink(destination: HelpView()) {
                            HStack {
                                Image(systemName: "info.square")
                                    .foregroundColor(.primary)
                                Text("Help")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                        
                        Divider()
                        
                        NavigationLink(destination: TellAFriendView()) {
                            HStack {
                                Image(systemName: "heart")
                                    .foregroundColor(.primary)
                                Text("Tell a friend")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding()
                    .background(Color.secondary.gradient.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    
                    VStack {
                        Button(action: {
                            showAlert = true
                        }, label: {
                            HStack {
                                Image(systemName: "iphone.gen3.slash")
                                    .foregroundColor(.primary)
                                Text("Log Out")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        })
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Log Out"),
                                message: Text("Are you sure you want to log out?"),
                                primaryButton: .destructive(Text("Log Out")) {
                                    logOut()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                    .padding()
                    .background(Color.secondary.gradient.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    .padding(.vertical)
                }
                .navigationBarTitle("TrustChat")
                .navigationBarTitleDisplayMode(.automatic)
                .padding()
            }
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
                    }
                } else {
                    // Kullanıcı oturumu açılmamış
                }
            } catch {
                // Hata durumu
            }
        }
    }
    
    /// Çıkış işlemleri burada yapılacak
    func logOut() {
        Task {
            do {
                try authManager.signOut()
                viewSelecterModel.selectedScreen = "LoginView"
            } catch {
                
            }
        }
    }
}
