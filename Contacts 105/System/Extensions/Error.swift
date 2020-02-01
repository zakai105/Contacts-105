//
//  Error.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

extension Error {
    
    var usefulDescription: String {
        let nSError = self as NSError
        return "\(nSError), \(nSError.userInfo)"
    }
}
