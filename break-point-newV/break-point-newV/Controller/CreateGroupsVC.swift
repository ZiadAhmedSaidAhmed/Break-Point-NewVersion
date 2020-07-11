//
//  CreateGroupsVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/7/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {

    //Outlets
    @IBOutlet weak var groupTitleTxtField: customTextField!
    @IBOutlet weak var groupDescreptionTxtField: customTextField!
    @IBOutlet weak var searchMemberTxtField: customTextField!
    
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArray = [String]()
    var selectedEmailsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchMemberTxtField.delegate = self
        searchMemberTxtField.addTarget(self, action: #selector(onEditingChanged), for: .editingChanged)
        doneBtn.isHidden = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
    
    @objc func onEditingChanged() {
        
        if searchMemberTxtField.text == "" {
            emailArray = []
            self.tableView.reloadData()
        } else {
            DataService.instance.searchUser(forQuery: searchMemberTxtField.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        if groupTitleTxtField.text != "" && groupDescreptionTxtField.text != "" {
            DataService.instance.getUidsForEmails(emailsArray: selectedEmailsArray) { (uidsArray) in
                
                var users = uidsArray
                users.append((Auth.auth().currentUser?.uid)!)
                DataService.instance.createGroup(withTitle: self.groupTitleTxtField.text!, description: self.groupDescreptionTxtField.text!, users: users) { (groupCreatedSuccessfully) in
                    if groupCreatedSuccessfully {
                        self.dismiss(animated: true, completion: nil)
                    } else { print("faild to create a group!") }
                }
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        
        let image = UIImage(named: "defaultProfileImage")
        
        if selectedEmailsArray.contains(emailArray[indexPath.row]) {
            cell.setViews(profileImage: image!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.setViews(profileImage: image!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !selectedEmailsArray.contains(cell.emailLbl.text!) {
            selectedEmailsArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = selectedEmailsArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            selectedEmailsArray = selectedEmailsArray.filter({ $0 != cell.emailLbl.text! })
            if selectedEmailsArray.count >= 1 {
                groupMemberLbl.text = selectedEmailsArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate {}
