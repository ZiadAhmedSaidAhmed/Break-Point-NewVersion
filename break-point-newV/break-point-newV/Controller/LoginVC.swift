//
//  LoginVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/2/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var emailTxtField: customTextField!
    @IBOutlet weak var passwordTxtField: customTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func signinPressed(_ sender: Any) {
        if emailTxtField.text != nil && passwordTxtField.text != nil {
            AuthService.instance.loginUser(withEmail: emailTxtField.text!, andPassword: passwordTxtField.text!) { (success, error) in
                
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: error?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!) { (success, error) in
                    
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!) { (success, error) in
                            self.dismiss(animated: true, completion: nil)
                            print("Successfully Registerd User")
                        }
                    } else {
                        print(String(describing: error?.localizedDescription))
                    }
                }
            }
        }
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
