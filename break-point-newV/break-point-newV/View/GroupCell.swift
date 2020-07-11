//
//  GroupCell.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/10/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescreptionLbl: UILabel!
    @IBOutlet weak var numberOfGroupMembersLbl: UILabel!
    
    func setViews(groupTitleLbl: String, groupDescreptionLbl: String, numberOfGroupMembersLbl: Int) {
        
        self.groupTitleLbl.text = groupTitleLbl
        self.groupDescreptionLbl.text = groupDescreptionLbl
        self.numberOfGroupMembersLbl.text = "\(numberOfGroupMembersLbl) members"
    }
}
