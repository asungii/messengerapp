//
//  ConversationsModels.swift
//  Messenger
//
//  Created by Laerdon Kim on 8/10/20.
//  Copyright © 2020 Laerdon Kim. All rights reserved.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
