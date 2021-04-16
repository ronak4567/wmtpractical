//
//  User.swift
//  ronak
//
//  Created by Depixed on 16/04/21.
//


import Foundation

// MARK: - User
class User {
    var meta: Meta?
    var data: DataClass?
    init() {
        
    }

    init(dict:Dictionary<String,Any>) {
        self.data = DataClass(dict: dict["data"] as? Dictionary<String, Any> ?? [:])
        self.meta = Meta(dict: dict["meta"] as? Dictionary<String, Any> ?? [:])
    }
}

// MARK: - DataClass
class DataClass {
    var user: UserClass?
    var token: Token?

    init(user: UserClass?, token: Token?) {
        self.user = user
        self.token = token
    }
    
    init(dict:Dictionary<String,Any>) {
        self.user = UserClass(dict: dict["user"] as? Dictionary<String, Any> ?? [:])
        self.token = Token(dict: dict["token"] as? Dictionary<String, Any> ?? [:])
    }
}

// MARK: - Token
class Token {
    var type, token, refreshToken: String?

    init(type: String?, token: String?, refreshToken: String?) {
        self.type = type
        self.token = token
        self.refreshToken = refreshToken
    }
    
    init(dict:Dictionary<String,Any>) {
        self.type = dict["type"] as? String
        self.token = dict["token"] as? String
        self.refreshToken = dict["refreshToken"] as? String
    }
}

// MARK: - UserClass
class UserClass {
    var username, email: String?
    var profilePic: String?
    var createdAt, updatedAt: String?
    var id: Int?

    init(username: String?, email: String?, profilePic: String?, createdAt: String?, updatedAt: String?, id: Int?) {
        self.username = username
        self.email = email
        self.profilePic = profilePic
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.id = id
    }
    
    init(dict:Dictionary<String,Any>) {
        self.username = dict["username"] as? String
        self.email = dict["email"] as? String
        self.profilePic = dict["profile_pic"] as? String
        self.createdAt = dict["created_at"] as? String
        self.updatedAt = dict["updated_at"] as? String
        self.id = dict["id"] as? Int
        
    }
    
    
}

// MARK: - Meta
class Meta {
    var status, message: String?

    init(status: String?, message: String?) {
        self.status = status
        self.message = message
    }
    
    init(dict:Dictionary<String,Any>) {
        self.status = dict["status"] as? String
        self.message = dict["message"] as? String
    }
}
