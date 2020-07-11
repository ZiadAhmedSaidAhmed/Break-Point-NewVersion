//
//  GroupChatVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/11/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit
import Firebase

class GroupChatVC: UIViewController {

    @IBOutlet weak var chatTitleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxtField: customTextField!
    @IBOutlet weak var txtAndBtnContainerView: UIView!
    
    var group: Group?
    var messagesArray = [Message]()
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtAndBtnContainerView.blindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatTitleLbl.text = group?.groupTitle
        DataService.instance.REF_GROUPS.observe(.value) { (DataSnapshot) in
            DataService.instance.getChatForGroup(group: self.group!) { (returnedMessagesArray) in
                self.messagesArray = returnedMessagesArray
            }
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        if messageTxtField.text != "" {
            sendBtn.isEnabled = false
            messageTxtField.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTxtField.text!, forUid: Auth.auth().currentUser!.uid, withGroupKey: group?.groupKey) { (Complete) in
                self.messageTxtField.text = ""
                self.sendBtn.isEnabled = true
                self.messageTxtField.isEnabled = true
            }
        }
    }
}

extension GroupChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupChatCell", for: indexPath) as? GroupChatCell else { return UITableViewCell() }
        
        let image = UIImage(named: "defaultProfileImage")
        let message = messagesArray[indexPath.row]
        DataService.instance.emailFromUserId(uid: message.senderId) { (username) in
            cell.setupViews(profileImage: image!, userEmail: username, content: message.content)
        }
        return cell
    }
}
