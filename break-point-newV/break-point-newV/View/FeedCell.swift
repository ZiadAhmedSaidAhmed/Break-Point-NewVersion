//
//  FeedCell.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/3/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userEmaillLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func setViews(userProfileImage: UIImage, userEmaillLbl: String, contentLbl: String) {
        self.userProfileImage.image = userProfileImage
        self.userEmaillLbl.text = userEmaillLbl
        self.contentLbl.text = contentLbl
    }
}
