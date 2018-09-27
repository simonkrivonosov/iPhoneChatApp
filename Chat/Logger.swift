//
//  Logger.swift
//  Chat
//
//  Created by Семен Кривоносов on 22.09.2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication.State {
    func toString() -> String {
        switch self {
        case .active:
            return "Active"
        case .inactive:
            return "Inactive"
        case .background:
            return "Background"
        }
    }
}

class Logger { // he logs only when we use target with flag -DWITH_LOG set
    
    var previousState: UIApplication.State = UIApplication.shared.applicationState
    
    func logApplicationTurnOn(methodName: String) {
        #if WITH_LOG
            print("Application moved from <Not runnnig> to <\(UIApplication.shared.applicationState.toString())>: <\(methodName)>")
            previousState = UIApplication.shared.applicationState
        #endif
    }
    
    func logChangeAppState(methodName: String) {
        #if WITH_LOG
            print("Application moved from <\(previousState.toString())> to <\(UIApplication.shared.applicationState.toString())>: <\(methodName)>")
            previousState = UIApplication.shared.applicationState
        #endif
    }
    func logCurMethod(methodName: String) {
        #if WITH_LOG
            print("<\(methodName)>")
        #endif
    }
}
