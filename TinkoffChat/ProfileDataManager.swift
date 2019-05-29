//
//  DataManager.swift
//  TinkoffChat
//
//  Created by Семен Кривоносов on 11.09.2019.
//  Copyright © 2019 Семен Кривоносов. All rights reserved.
//

import Foundation

protocol ProfileDataManager {
    var profileUsername: String? { get }
    var profileAbout: String? { get }
    var profileAvatar: UIImage? { get }
    var profileDataDelegate: ProfileDataManagerDelegate? { get set }
    func saveProfileData(username: String?, about: String?, avatar: UIImage?) // if some parameters are submitted as nil then it means that they didn't changed
    func loadProfileData()
}
