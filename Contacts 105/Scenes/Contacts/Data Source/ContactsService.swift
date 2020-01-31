//
//  ContactsService.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation
import Contacts

struct ContactsService {
    
    func RetrieveContacts(callBack:([CNContact]?) -> Void) {
        guard let keyDescriptors = cNKeyDescriptors else { return }
        
        let contactStore = CNContactStore()
        let containers = cNContainers(from: contactStore)
        
        var results = [CNContact]()
        
        containers?.forEach {
            
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: $0.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keyDescriptors)
                results.append(contentsOf: containerResults)
            } catch {
                print(error.usefulDescription)
            }
        }

        callBack(results)
    }
}

// MARK: - Helpers

private extension ContactsService {
    
    func cNContainers(from contactStore: CNContactStore) -> [CNContainer]? {
        
        do {
            return try contactStore.containers(matching: nil)
        } catch {
            print(error.usefulDescription)
            return nil
        }
    }
    
    var cNKeyDescriptors: [CNKeyDescriptor]? {
        let keysToFetch: [Any] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey
        ]
        
        return keysToFetch as? [CNKeyDescriptor]
    }
}

extension Error {
    
    var usefulDescription: String {
        let nSError = self as NSError
        return "\(nSError), \(nSError.userInfo)"
    }
}
