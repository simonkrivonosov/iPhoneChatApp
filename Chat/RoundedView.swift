//
//  RoundedView.swift
//  Chat
//
//  Created by Семен Кривоносов on 20/03/2019.
//  Copyright © 2019 Семен Кривоносов. All rights reserved.
//

import Foundation

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layer.cornerRadius = cornerRadius
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = cornerRadius
    }
    
}
