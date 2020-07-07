//
//  CreatePostVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/3/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.blindToKeyboard()
        emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say somthing here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUid: Auth.auth().currentUser!.uid, withGroupKey: nil) { (complete) in
                if complete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("there was an error")
                }
            }
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension CreatePostVC {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
