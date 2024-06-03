//
//  TrustChatApp.swift
//  TrustChat
//
//  Created by Çağan Durgun on 30.05.2024.
//

import SwiftUI
import FirebaseCore
/// import BackgroundTasks

@main
struct TrustChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewSelecterModel = ViewSelecterModel()
    var body: some Scene {
        WindowGroup {
            ContentView(authManager: AuthManager(), userManager: UserManager())
                .environmentObject(viewSelecterModel)
        }
        /**
         .backgroundTask(.appRefresh("message")) {
             //
             scheduleAppRefresh()
             
             if await messageAPIControl() {
                 await notifyUser()
             }
         }
         */
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


/**
 
 func messageAPIControl() async -> Bool {
     return false
 }

 func notifyUser() async {
     
 }

 // Efficiency awaits
 func scheduleAppRefresh() {
     let first = Calendar.current.startOfDay(for: .now)
     let second = Calendar.current.date(byAdding: .second, value: 1, to: first)!
     
     let request = BGAppRefreshTaskRequest(identifier: "message")
     request.earliestBeginDate = second
     try? BGTaskScheduler.shared.submit(request)
 }
 */
