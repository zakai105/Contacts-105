//
//  UIImage.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(data: Data?) {
        guard let data = data else { return nil }
        self.init(data: data)
    }
}
