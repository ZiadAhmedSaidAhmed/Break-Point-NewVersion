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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setViews(profileImage: UIImage, email: String, isSelected: Bool) {
        self.profileImage.image = profileImage
        self.emailLbl.text = email
        if isSelected {
            checkImage.isHidden = false
        } else { checkImage.isHidden = true }
    }
}
