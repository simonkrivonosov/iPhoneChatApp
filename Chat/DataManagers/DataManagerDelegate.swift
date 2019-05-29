//
//  DataManagerDelegate.swift
//  Chat
//
//  Created by Семен Кривоносов on 28/10/2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

protocol DataManagerDelegate {
    func loadingDataFinished()
    func savingDataFinished()
    func savingDataFailed()
}
