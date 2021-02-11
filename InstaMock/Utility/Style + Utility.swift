//
//  Style + Utility.swift
//  InstaMock
//
//  Created by Susana on 2/10/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation
import UIKit

class Style {

    static func styleFilledButton(_ button: UIButton) {
        button.backgroundColor = UIColor.purple
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func passwordIsValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
