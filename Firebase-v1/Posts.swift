//
//  Posts.swift
//  Firebase-v1
//

import Foundation

class Post {
    
    var postId: String?
    var message: String?
    var sender: String?
    
    init(id: String, message: String, sender: String) {
        self.postId = id
        self.message = message
        self.sender = sender
    }

}