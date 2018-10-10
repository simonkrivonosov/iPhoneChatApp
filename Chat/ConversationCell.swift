//
//  ConversationCell.swift
//  Chat
//
//  Created by Семен Кривоносов on 08/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

protocol ConversationCellConfiguration: class {
    var name : String? {get set}
    var message : String? {get set}
    var date : Date? {get set}
    var online : Bool {get set}
    var hasUnreadMessage : Bool {get set}
}

class ConversationCell: UITableViewCell, ConversationCellConfiguration {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var name: String? {
        didSet {
            nameLabel.text = name ?? "Undefined name"
        }
    }
    var message: String? {
        didSet {
            guard let messageText = message else {
                messageLabel.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
                messageLabel.text = "No messages yet"
                return
            }
            messageLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            messageLabel.text = messageText
        }
    }
    var date: Date? {
        didSet {
            if let date = date {
                let dateFormatter = DateFormatter()
                if Calendar.current.isDate(Date(), inSameDayAs: date) {
                    dateFormatter.dateFormat = "HH:mm"
                    timeLabel.text = dateFormatter.string(from: date)
                } else {
                    //dateFormatter.dateStyle = .long
                    //dateFormatter.timeStyle = .none
                    dateFormatter.dateFormat = "dd MMM"
                    timeLabel.text = dateFormatter.string(from: date)
                }
            }
        }
    }
    var online: Bool = false {
        didSet {
            self.backgroundColor = online ? #colorLiteral(red: 0.9332608581, green: 1, blue: 0.7336280942, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    var hasUnreadMessage: Bool = false {
        didSet {
            if message != nil && hasUnreadMessage {
                messageLabel.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
            }
        }
    }
    func setParams(_ name : String?,
                   _ message : String?,
                   _ date : Date?,
                   _ online : Bool,
                   _ hasUnreadMessage : Bool) {
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadMessage = hasUnreadMessage
    }
}
