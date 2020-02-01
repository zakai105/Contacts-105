//
//  ContactPresenter.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

struct ContactPresenter: ContactPresentable {
    
    private weak var viewController: ContactDisplayable?
    private let model: ContactModelable
    var dataSource: ContactDataStructure?

    init(viewController: ContactDisplayable, identifier: String?) {
        self.viewController = viewController
        model = ContactModel()
        
        if let identifier = identifier {
            dataSource = model.readContact(withIdentifier: identifier)
        }
    }
    
    func didAdd(contact: RawContactDataStructure) {
        
        if let error = model.createContact(with: contact) {
            print(error.usefulDescription)
            viewController?.display(alert: failToCreateContactAlert)
            return
        }
        
        viewController?.dismiss()
    }
    
    func didUpdate(contact: RawContactDataStructure) {
        
        if let error = model.updateContact(with: contact) {
            print(error.usefulDescription)
            viewController?.display(alert: failToCreateContactAlert)
            return
        }
        
        viewController?.dismiss()
    }
    
    func didPressDelete() {
        guard let identifier = dataSource?.identifier else { return }
        
        let ac = UIAlertController(title: "R U sure?", message: "to delete the contact?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            
            if let error = self.model.deleteContact(withIdentifier: identifier) {
                print(error.usefulDescription)
                self.viewController?.display(alert: self.failToDeleteContactAlert)
                return
            }
            
            self.viewController?.dismiss()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController?.display(alert: ac)
    }
    
    func didPressAvatarButton() {
        let ac = UIAlertController(title: "Choose image from", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.viewController?.displayImagePicker(of: .camera)
            } else {
                self.viewController?.display(alert: self.noCameraAlert)
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {_ in
            
            self.viewController?.displayImagePicker(of: .photoLibrary)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController?.display(alert: ac)
    }
}

// MARK: - Helpers

private extension ContactPresenter {
    
    var noCameraAlert: UIAlertController {
        let ac = UIAlertController(title: "Warning", message: "You don't have a camera", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Whoops!?", style: .cancel))
        return ac
    }
    
    var failToCreateContactAlert: UIAlertController {
        let ac = UIAlertController(title: "Problem", message: "You can't add the contact", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hmmmm..", style: .cancel))
        return ac
    }
    
    var failToUpdateContactAlert: UIAlertController {
        let ac = UIAlertController(title: "Problem", message: "You can't update the contact", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hmmmm..", style: .cancel))
        return ac
    }
    
    var failToDeleteContactAlert: UIAlertController {
        let ac = UIAlertController(title: "Problem", message: "You can't delete the contact", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hmmmm..", style: .cancel))
        return ac
    }
}

