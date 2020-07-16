//
//  SecondViewController.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/2/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var groupsArray = [Group]()
    var emails = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (dataSnapshot) in
            DataService.instance.getGroupsForCurrentUser(handler: { (returnedArray) in
                self.groupsArray = returnedArray.reversed()
                self.tableView.reloadData()
            })
        }
    }
}

extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        
        cell.setViews(groupTitleLbl: groupsArray[indexPath.row].groupTitle, groupDescreptionLbl: groupsArray[indexPath.row].groupDes, numberOfGroupMembersLbl: groupsArray[indexPath.row].numOfMembers)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupChatVC = storyboard?.instantiateViewController(identifier: "groupChatVC") as? GroupChatVC else { return }
        let group =  groupsArray[indexPath.row]
        
        groupChatVC.initData(forGroup: group)
        showDetail(groupChatVC)
    }
}
