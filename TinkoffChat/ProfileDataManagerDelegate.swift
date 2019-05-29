//
//  DataManagerDelegate.swift
//  TinkoffChat
//
//  Created by Семен Кривоносов on 11.09.2019.
//  Copyright © 2019 Семен Кривоносов. All rights reserved.
//

import Foundation

protocol ProfileDataManagerDelegate: class {
    func loadingProfileDataFinished()
    func savingProfileDataFinished()
    func savingProfileDataFailed()
}
