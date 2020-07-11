//
//  groupChatCell.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/11/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class GroupChatCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func setupViews(profileImage: UIImage, userEmail: String, content: String) {
        self.profileImage.image = profileImage
        self.userEmailLbl.text = userEmail
        self.contentLbl.text = content
    }
}
