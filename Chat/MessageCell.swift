//
//  MessageCell.swift
//  Chat
//
//  Created by Семен Кривоносов on 08/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

protocol MessageCellConfiguration : class {
    var messageText: String? {get set}
}

class MessageCell: UITableViewCell, MessageCellConfiguration {
    
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var messageText: String? {
        didSet {
            messageLabel.text = messageText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageContainer.layer.cornerRadius = 15
        messageContainer.layer.borderWidth = 0.5
    }
}


