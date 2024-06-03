//
//  MessageRowView.swift
//  TrustChat
//
//  Created by Çağan Durgun on 1.06.2024.
//

import SwiftUI
import Foundation

struct MessageRowView: View {
    @EnvironmentObject var userModel: UserModel
    var message: MessageModel // MessageModel tipi, gösterilecek mesaj verilerini içerir
    
    
    var body: some View {
        /// bu görsellik message row viewda sağlanmalı
        VStack(alignment: .leading) {
            Text(message.message)
            
            Text(formattedTime(from: message.date))
                .foregroundColor(.secondary)
                .font(.caption)
                .fontWeight(.regular)
        }
        .padding(10)
        .background(
            userModel.email == message.messageSender ? Color.blue.gradient.opacity(0.3) : Color.green.gradient.opacity(0.3)
        )
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
    
    func formattedTime(from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        if let hour = components.hour, let minute = components.minute {
            var newComponents = DateComponents()
            newComponents.hour = hour
            newComponents.minute = minute
            newComponents.year = 2000
            newComponents.month = 1
            newComponents.day = 1
            
            if let timeOnlyDate = calendar.date(from: newComponents) {
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH:mm"
                return timeFormatter.string(from: timeOnlyDate)
            }
        }
        
        return "Tarih formatı hatalı"
    }
}

/// bu blok test için kullanılmaktadır.
struct MessageRowView_Previews: PreviewProvider {
    static var previews: some View {
        let userModel = UserModel() // Geçici olarak bir userModel örneği oluşturuldu
        let sampleMessage = MessageModel(messageSender: "Gönderen", messageGetter: "Alan", message: "Bu kısımda mesaj yazacaktır", date: Date())
        return MessageRowView(message: sampleMessage)
            .environmentObject(userModel) // MessageRowView'ın userModel ortamına enjekte edilmesi
    }
}

