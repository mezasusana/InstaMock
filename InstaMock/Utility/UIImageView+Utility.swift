//
//  UIImageView+Utility.swift
//  InstaMock
//
//  Created by Susana on 1/31/21.
//  Copyright © 2021 Susana Meza. All rights reserved.
//

import Foundation

import UIKit

extension UIImageView {
   public func setRounded() {
    let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
