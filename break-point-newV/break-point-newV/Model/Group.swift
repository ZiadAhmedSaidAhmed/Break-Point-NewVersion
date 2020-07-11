//
//  File.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/10/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import Foundation

class Group {
    
    private var _groupTitle: String
    private var _groupDes: String
    private var _members: [String]
    private var _numOfMembers: Int
    private var _groupKey: String
    
    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDes: String {
        return _groupDes
    }
    
    var members: [String] {
        return _members
    }
    
    var numOfMembers: Int {
        return _numOfMembers
    }
    
    var groupKey: String {
        return _groupKey
    }
    
    init(groupTitle: String, groupDes: String, members: [String], numOfMembers: Int, groupKey: String) {
        self._groupTitle = groupTitle
        self._groupDes = groupDes
        self._members = members
        self._numOfMembers = numOfMembers
        self._groupKey = groupKey
    }
}
