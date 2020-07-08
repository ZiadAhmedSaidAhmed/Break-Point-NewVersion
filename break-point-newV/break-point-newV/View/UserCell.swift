//
//  userCell.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/7/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var showing = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            } else {
                checkImage.isHidden = true
                showing = false
            }
        }
    }

    func setViews(profileImage: UIImage, email: String, isSelected: Bool) {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        if isSelected {
            self.checkImage.isHidden = false
        } else { self.checkImage.isHidden = true }
    }
}
