//
//  NotificationManager.swift
//  TrustChat
//
//  Created by Çağan Durgun on 2.06.2024.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    
    /// bunu notification bölümünde ve uygulamaya girerken kullanmak lazım?
    ///
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("succes")
            } else if error != nil {
                print("error")
            }
        }
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title:  String, body: String) {
        var trigger: UNNotificationTrigger?
        
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
