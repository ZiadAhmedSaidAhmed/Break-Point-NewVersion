//
//  meVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/3/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit
import Firebase

class meVC: UIViewController {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userEmailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func signoutBtnPressed(_ sender: Any) {
        
        let logOutPopOut = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Logout", style: .destructive) { (logoutBtnTapped) in
            
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(identifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logOutPopOut.addAction(logOutAction)
        present(logOutPopOut, animated: true, completion: nil)
    }
    
}
