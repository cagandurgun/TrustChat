//
//  ChatView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 30.05.2024.
//

import SwiftUI

/// arka planda çalışmasını istediğim yer burası.
///
/// Select chat view ile burayı birleştirelim.
/// eğer hiç sohbet yoksa ekranda bir şeyler yazsın.  --->  userModel.karsi_taraf != "" 
///
///
/// burada .onRecive  olması gerekiyor. olay şu eğer biri bizi eklediyse bizim kendi user modelimizi güncellememiz gerek.
///
///
///
struct ChatView: View {
    @State private var timer: DispatchSourceTimer?
    @EnvironmentObject var userModel: UserModel
    let userManager: UserManager
    let authManager: AuthManager
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack {
                    
                    LazyVStack(alignment: .leading) {
                        ForEach(userModel.chats, id: \.email) { addressee in
                            ChatRowView(addresseeModel: addressee)
                                .environmentObject(userModel)
                        }
                        /// burada foreach kullanılark tüm sohbetler listelenecek. eğer hiç sohbet yoksa ekrana bir şey bulamadık yazsın
                    }
                    .padding()
                    
                    
                }
                
            }
            .navigationBarTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: StartChatView(userManager: userManager).environmentObject(userModel)) {
                        Image(systemName: "person.badge.plus")
                    }
                }
            }
            .padding()
            .onAppear(perform: startTimer)
            .onDisappear(perform: stopTimer)
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
    
    
    /// for fetching messagges
    func startTimer() {
        let queue = DispatchQueue(label: "com.cagandurgun.trustchat.timer", attributes: .concurrent)
        let newTimer = DispatchSource.makeTimerSource(queue: queue)
        newTimer.schedule(deadline: .now(), repeating: .milliseconds(1000)) // Adjust the repeating interval as needed
        newTimer.setEventHandler { [weak timer = newTimer] in
            print("timer started: \(timer!)")/// warningden kurtulmak için.
            DispatchQueue.main.async {
                self.loadUserData()
            }
        }
        
        newTimer.resume()
        
        DispatchQueue.main.async {
            self.timer = newTimer
        }
    }
    
    /// for fetching messagges
    func stopTimer() {
        DispatchQueue.main.async {
            self.timer?.cancel()
            self.timer = nil
        }
    }
}
