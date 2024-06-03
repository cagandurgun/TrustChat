//
//  MessageModel.swift
//  TrustChat
//
//  Created by Çağan Durgun on 1.06.2024.
//

import Foundation


/// Burada mesajın içermesi gereken bilgiler vardır.
/// Zaman olabilir. ki databasede zamana göre sıralansın.
///
 
struct MessageModel: Codable {
    let messageSender: String
    let messageGetter: String
    let message: String
    let date: Date
}

/// database için ayrı bir message model oluşturulabilr? çünkü hangi kullanıcının altında olduğu belli ama olmasa da olur 
