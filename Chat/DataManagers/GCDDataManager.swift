//
//  GCDDataManager.swift
//  Chat
//
//  Created by Семен Кривоносов on 26/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import Foundation

class GCDDataManager: DataManager {
    
    var username: String?
    var about: String?
    var avatar: UIImage?
    private var usernameKey: String
    private var aboutKey: String
    private var avatarFile: String
    private var isLastSaveSuccess: Bool = true
    
    required init(usernameKey: String, aboutKey: String, avatarFile: String) {
        self.usernameKey = usernameKey
        self.aboutKey = aboutKey
        self.avatarFile = avatarFile
    }
    
    var delegate: DataManagerDelegate?
    
    func saveData(username: String?, about: String?, avatar: UIImage?) {
        isLastSaveSuccess = true
        let queue = DispatchQueue(label:"writeSerialQueue")
        queue.async{
            if let image = avatar {
                if self.isLastSaveSuccess {
                    self.isLastSaveSuccess = GCDDataManager.SaveDataToFile(image: image, file: self.avatarFile)
                }
            }
            if let info = username {
                if self.isLastSaveSuccess {
                    self.isLastSaveSuccess = GCDDataManager.SaveInfoToUserDefaults(info: info, key: self.usernameKey)
                }
            }
            if let info = about {
                if self.isLastSaveSuccess {
                    self.isLastSaveSuccess = GCDDataManager.SaveInfoToUserDefaults(info: info, key: self.aboutKey)
                }
            }
            DispatchQueue.main.async {
                if self.isLastSaveSuccess {
                    self.delegate?.savingDataFinished()
                } else {
                    self.delegate?.savingDataFailed()
                }
            }
        }
    }
    
    func loadData() {
        let queue = DispatchQueue(label:"readSerialQueue")
        queue.async{
            self.avatar = GCDDataManager.LoadDataFromFile(file: self.avatarFile)
            self.username = GCDDataManager.LoadInfoFromUserDefaults(key: self.usernameKey)
            self.about = GCDDataManager.LoadInfoFromUserDefaults(key: self.aboutKey)
            DispatchQueue.main.async {
                self.delegate?.loadingDataFinished()
            }
        }
    }
    
}
