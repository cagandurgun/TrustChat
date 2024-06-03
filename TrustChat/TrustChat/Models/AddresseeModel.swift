//
//  AddresseeModel.swift
//  TrustChat
//
//  Created by Çağan Durgun on 2.06.2024.
//

import Foundation

struct AddresseeModel: Codable {
    let email: String /// for identifying
    let name: String /// for oratory
    let chatHistory: [MessageModel] // for conversation history
}
