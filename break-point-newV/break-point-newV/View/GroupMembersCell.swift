//
//  GroupMembersCell.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/12/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class GroupMembersCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    
    func setupViews(profileImage: UIImage, email: String) {
        
        self.profileImage.image = profileImage
        self.emailLbl.text = email
    }
}
