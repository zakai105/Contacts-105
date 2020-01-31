//
//  SearchViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/27/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts

protocol TrafficLightViewDelegate: NSObjectProtocol {
    func displayTrafficLight(description:(String))
}

class SearchViewController: UIViewController, CNContactPickerDelegate, CNContactViewControllerDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    private lazy var trafficLightPresenter = TrafficLightPresenter(
        viewDelegate: self,
        trafficLightService: TrafficLightService()
    )

    
    func onClickPickContact() {
        
        let pickerViewController = CNContactPickerViewController()
//        pickerViewController.displayedPropertyKeys = [CNContactGivenNameKey, CNContactPhoneNumbersKey]
        pickerViewController.modalPresentationStyle = .overFullScreen
        pickerViewController.delegate = self
        present(pickerViewController, animated: false, completion: nil)
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        
    }

    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // You can fetch selected name and number in the following way
        
        // user name
        let userName:String = contact.givenName
        
        // user phone number
//        let userPhoneNumbers:[CNLabeledValue<CNPhoneNumber>] = contact.phoneNumbers
//        let firstPhoneNumber:CNPhoneNumber = userPhoneNumbers[0].value
//
//
//        // user phone number string
//        let primaryPhoneNumberStr:String = firstPhoneNumber.stringValue
//
//        print(primaryPhoneNumberStr)
        
        let contact = contact
        
//        let contactViewController = CNContactViewController(for: contact)
        let contactViewController = CNContactViewController(forNewContact: nil)

        contactViewController.hidesBottomBarWhenPushed = true
        contactViewController.allowsEditing = true
        contactViewController.allowsActions = false
        contactViewController.delegate = self
        // 3
//        navigationController?.navigationBar.tintColor = .red
        navigationController?.show(contactViewController, sender: nil)
        
//        present(contactViewController, animated: true)

    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {

    }
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        onClickPickContact()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func redLightAction(_ sender: Any) {
        onClickPickContact()
        trafficLightPresenter.trafficLightColorSelected(colorName:"Red")
    }
    
    @IBAction func yellowLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Yellow")
        
        let vc = ViewController2()
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func greenLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Green")
        
//        let storyboard = UIStoryboard(name: "SearchViewController2", bundle: nil)
//        let controller = storyboard.instantiateInitialViewController()!
//        navigationController?.pushViewController(controller, animated: true)
        
//        let svc = SearchViewController2(searchResultsController: nil)
//        present(svc, animated: true, completion: nil)
        
        let cvc = ContactsViewController()
        navigationController?.pushViewController(cvc, animated: true)
    }
}

extension SearchViewController: TrafficLightViewDelegate {
    
    func displayTrafficLight(description:(String)) {
        descriptionLabel.text = description
    }
}

class ContactPickerViewController:  CNContactPickerViewController {
    
}
