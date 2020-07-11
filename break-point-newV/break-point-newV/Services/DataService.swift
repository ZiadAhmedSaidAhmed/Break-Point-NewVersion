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
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
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
    
    func getUidsForEmails(emailsArray: [String], handler: @escaping([String]) -> ()) {
        var uidsArray = [String]()
        
        REF_USERS.observe(.value) { (usersSnapshot) in
            guard let usersSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in usersSnapshot {
                
                let email = user.childSnapshot(forPath: "email").value as! String
                if emailsArray.contains(email) {
                    uidsArray.append(user.key)
                }
            }
            handler(uidsArray)
        }
    }

    func createGroup(withTitle title: String, description: String, users: [String], handler: @escaping(Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "users": users])
        handler(true)
    }
    
    func getGroupsForCurrentUser(handler: @escaping(_ groupsArray: [Group]) -> ()) {
        
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupsSnapshot) in
            
            guard let groupsSnapshot = groupsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for group in groupsSnapshot {
                
                let memberArray = group.childSnapshot(forPath: "users").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let groupDescription = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(groupTitle: title, groupDes: groupDescription, members: memberArray, numOfMembers: memberArray.count, groupKey: group.key)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }
    
    func getChatForGroup(group: Group, handler: @escaping(_ messageArray: [Message]) -> ()) {
        var messagesArray = [Message]()
        
        REF_GROUPS.child(group.groupKey).child("messages").observeSingleEvent(of: .value) { (groupMessagesSnapshot) in
            guard let groupMessagesSnapshot = groupMessagesSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for groupMessages in groupMessagesSnapshot {
                
                let content = groupMessages.childSnapshot(forPath: "content").value as! String
                let uid = groupMessages.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: uid)
                messagesArray.append(message)
            }
            handler(messagesArray)
        }
    }
}
