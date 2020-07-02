//
//  AuthVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/2/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signinWithEmailPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(identifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
    }
    
    @IBAction func gmailLoginPressd(_ sender: Any) {
    }
}
