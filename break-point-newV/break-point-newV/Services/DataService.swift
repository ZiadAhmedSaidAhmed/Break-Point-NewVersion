//
//  DataService.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/2/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUid uid: String, withGroupKey groupKey: String?, sendComplete: @escaping(_ success: Bool) -> ()) {
        if groupKey != nil {
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    
    func getFeedMessages(handler: @escaping(_ messages: [Message]) -> ()) {
        
        var messageArray = [Message]()

        REF_FEED.observeSingleEvent(of: .value) { (feedMessagesSnapshot) in
            guard let feedMessagesSnapshot = feedMessagesSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessagesSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    func emailFromUserId(uid: String, handler: @escaping(_ useremail: String) -> ()) {
        
        REF_USERS.observeSingleEvent(of: .value) { (usersSnapshot) in
            guard let usersSnaphsot = usersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersSnaphsot {
                
                if user.key == uid{
                        handler(user.childSnapshot(forPath: "email").value as! String)
                    }
                }
            }
        }
    
    func searchUser(forQuery query: String, handler: @escaping(_ emailArray: [String]) -> ()) {
        
        var emailArray = [String]()
        REF_USERS.observe(.value) { (usersSnapshot) in
            
            guard let usersSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in usersSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
}
