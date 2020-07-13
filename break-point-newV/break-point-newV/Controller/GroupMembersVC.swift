//
//  GroupMembersVC.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/12/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class GroupMembersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    var group: [String]?
//    func initGroup(group: [String]) {
//        self.group = group
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    @IBAction func exitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension GroupMembersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.group!.count
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupMembersCell", for: indexPath) as? GroupMembersCell else { return UITableViewCell() }
        let image = UIImage(named: "defaluProfileImage")
        //cell.setupViews(profileImage: image!, email: group![indexPath.row])
        return cell
    }
}
