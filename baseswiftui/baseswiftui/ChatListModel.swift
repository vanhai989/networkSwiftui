//
//  ChatListModel.swift
//  baseswiftui
//
//  Created by Hai Dev on 02/10/2022.
//

import Foundation

struct Message: Codable {
     var message: String
}

struct ChatListModel: Codable {
    var chats: [ChatModel]
}

struct ChatModel: Identifiable, Codable {
    var id: Int
    var chatName: String
    var image: String
    var message: ChatPreveiwMessage?
    var read: Bool
}

struct ChatPreveiwMessage: Codable {
    var content: String
    var created_at: String
}
