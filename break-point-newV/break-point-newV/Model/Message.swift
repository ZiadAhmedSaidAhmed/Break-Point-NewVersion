//
//  File.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/5/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import Foundation

class Message {
    
    private var _content: String!
    private var _senderId: String!
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content: String, senderId: String) {
        _content = content
        _senderId = senderId
    }
}
