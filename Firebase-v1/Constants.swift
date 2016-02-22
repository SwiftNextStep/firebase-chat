//
//  Constants.swift
//  Firebase-v1
//

import Foundation
import Firebase

let FirebaseApp = Firebase(url: "https://swaxu1.firebaseio.com")
let FirebaseUsers = Firebase(url: "https://swaxu1.firebaseio.com/users")
let FirebasePosts = Firebase(url: "https://swaxu1.firebaseio.com/posts")

var NEW_USER = false
var KEY_UID = ""
var HANDLE = ""

var users = [String:String]()

// FIREBASE ERROR CODES
let CODE_INVALID_EMAIL = -5
let CODE_BLANK_PASSWORD = -6
let CODE_ACCOUNT_NONEXIST = -8

// FIREBASE Keys
let KEY_ISONLINE = "isOnline"