//
//  ViewController.swift
//  Chat
//
//  Created by Семен Кривоносов on 22.09.2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var logger: Logger = Logger()

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.logCurMethod(methodName: #function)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logger.logCurMethod(methodName: #function)
    }
}

