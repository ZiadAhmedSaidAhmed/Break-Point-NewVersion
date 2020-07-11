//
//  FirstViewController.swift
//  break-point-newV
//
//  Created by Ziad Ahmed Said Ahmed on 7/2/20.
//  Copyright © 2020 Ziad Ahmed Said Ahmed. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var messageArray = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.REF_FEED.observe(.value) { (snapshot) in
            DataService.instance.getFeedMessages(handler: { (returnedMessageArray) in
                self.messageArray = returnedMessageArray.reversed()
                    self.tableView.reloadData()
            })
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
        
        let profileImage = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        DataService.instance.emailFromUserId(uid: message.senderId) { (userEmail) in
            
            cell.setViews(userProfileImage: profileImage!, userEmaillLbl: userEmail, contentLbl: message.content)
            
        }
        return cell
    }
    
}
