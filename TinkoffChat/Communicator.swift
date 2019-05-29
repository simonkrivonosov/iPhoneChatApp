//
//  Communicator.swift
//  TinkoffChat
//
//  Created by Семен Кривоносов on 11.09.2019.
//  Copyright © 2019 Семен Кривоносов. All rights reserved.
//

import Foundation

protocol Communicator {
    func sendMessage(string: String, to userId: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?)
    var delegate: CommunicatorDelegate? { get set }
    var online: Bool? { get set }
}
