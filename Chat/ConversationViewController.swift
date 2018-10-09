//
//  ConversationViewController.swift
//  Chat
//
//  Created by Семен Кривоносов on 08/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

class ConversationViewController: UITableViewController {

    let messageExamples = ["aaaaaaa", "h", "bbbbbbbbbbbbbbbb", "dddddddddddddddddddddd", "gggggggggggggggggggggggggggg", "uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu", "sdjfklsdkvjdsklvdfsnvms,adcvdfvdsfvsdfvdfv", "dlgnds;fglnkdslk;afdgljksgldafjbkdkslasfljnsakljbfnsvmackdvbflnjklsvkma;dsvlnbksxbvnsdkvbsndvkbsdn,vmsd,vsmd,vs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageExamples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String
        if indexPath.row % 2 == 0 {
            identifier = "OutComingMessageCell"
        } else {
            identifier = "InComingMessageCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MessageCell
        cell.messageText = self.messageExamples[indexPath.row]
        
        return cell
    }
}
