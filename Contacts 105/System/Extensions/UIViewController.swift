//
//  UIViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var safeAreaInsets: UIEdgeInsets {
        
        if #available(iOS 11.0, *) { return view.safeAreaInsets }
        return UIEdgeInsets.zero
    }
}
