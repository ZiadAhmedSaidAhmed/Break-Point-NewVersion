//
//  CreateGroupsVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/7/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController {

    //Outlets
    @IBOutlet weak var groupTitleTxtField: customTextField!
    @IBOutlet weak var groupDescreptionTxtField: customTextField!
    @IBOutlet weak var searchMemberTxtField: customTextField!
    
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchMemberTxtField.delegate = self
        searchMemberTxtField.addTarget(self, action: #selector(onEditingChanged), for: .editingChanged)
    }
    
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
        cell.setViews(profileImage: image!, email: emailArray[indexPath.row], isSelected: true)
        return cell
    }
}

extension CreateGroupsVC: UITextFieldDelegate {}
