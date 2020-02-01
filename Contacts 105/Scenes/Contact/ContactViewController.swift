//
//  ContactViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
        
    private var presenter: ContactPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ContactPresenter(viewController: self)
        navigationItem.rightBarButtonItem = editButtonItem
        view.backgroundColor = .red
    }
}

// MARK: - Contact displayable

extension ContactViewController: ContactDisplayable {
    
    func display(contact: ContactsDataStructure) {
        
        // TODO: - do somthing...
    }
}
