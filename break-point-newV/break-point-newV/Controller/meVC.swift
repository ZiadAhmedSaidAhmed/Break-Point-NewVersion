//
//  meVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/3/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class meVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signoutBtnPressed(_ sender: Any) {
        AuthService.instance.logoutUser()
    }
    
}
