//
//  CommunicatorDelegate.swift
//  TinkoffChat
//
//  Created by Семен Кривоносов on 11.09.2019.
//  Copyright © 2019 Семен Кривоносов. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate: class {
    //discovering
    func didFoundUser(userId: String, userName: String?)
    func didLostUser(userId: String)
    //errors
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    //messages
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}
