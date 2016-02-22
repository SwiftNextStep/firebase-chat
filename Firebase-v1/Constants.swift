//
//  Constants.swift
//  Firebase-v1
//

import Foundation
import Firebase

let FirebaseApp = Firebase(url: "https://<yourAppID>.firebaseio.com")
let FirebaseUsers = Firebase(url: "https://<yourAppID>.firebaseio.com/users")
let FirebasePosts = Firebase(url: "https://<yourAppID>.firebaseio.com/posts")

typealias JSONDictionary = [String:AnyObject]

var NEW_USER = false
var KEY_UID = ""
var HANDLE = ""

var users = [String:String]()

// FIREBASE ERROR CODES
let CODE_INVALID_EMAIL = -5
let CODE_BLANK_PASSWORD = -6
let CODE_ACCOUNT_NONEXIST = -8