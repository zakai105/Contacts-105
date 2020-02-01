//
//  ContactContract.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

protocol ContactDisplayable: class {
    func display(alert: UIAlertController)
    func displayImagePicker(of sourceType: UIImagePickerController.SourceType)
    func dismiss()
}

protocol ContactPresentable {
    var dataSource: ContactDataStructure? { get }
    func didAdd(contact: RawContactDataStructure)
    func didUpdate(contact: RawContactDataStructure)
    func didPressDelete()
    func didPressAvatarButton()
}

protocol ContactModelable {
    func createContact(with contact: RawContactDataStructure) -> Error?
    func readContact(withIdentifier identifier: String) -> ContactDataStructure?
    func updateContact(with contact: RawContactDataStructure) -> Error?
    func deleteContact(withIdentifier identifier: String) -> Error?
}
