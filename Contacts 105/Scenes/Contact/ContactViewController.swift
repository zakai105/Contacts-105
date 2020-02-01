//
//  ContactViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

import Contacts

class ContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    var isAdding = false
    var identifier: String?
    private var presenter: ContactPresentable?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ContactPresenter(viewController: self, identifier: identifier)
        
        title = presenter?.dataSource?.name
        navigationItem.rightBarButtonItem = editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        avatarImageView.image = presenter?.dataSource?.avatar
        
        if isAdding {
            setEditing(true, animated: false)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing {
            let name = "TextFieldCell"
            tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
            tableView.reloadData()
        } else {
            
            if isAdding {
                let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldCell
                let phoneNumbersCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? TextFieldCell
                let emailAddressesCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? TextFieldCell

                let contact = NewContactDataStructure(
                    name: nameCell?.textField.text,
                    avatar: nil,
                    phoneNumbers: [phoneNumbersCell?.textField.text],
                    emailAddresses: [emailAddressesCell?.textField.text]
                )
                
                presenter?.didAdd(contact: contact)

            } else {
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func avatarButtonPressed(_ sender: UIButton) {
        pickImage(self) {
            self.avatarImageView.image = $0
        }
    }
    
    var picker = UIImagePickerController();
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        // Add the actions
        picker.delegate = self
        let ac = UIAlertController(title: "Choose image from", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in self.openCamera() }))
        ac.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in self.openGallery() }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true, completion: nil)
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Whoops", style: .cancel))
            present(ac, animated: true, completion: nil)
        }
    }
    func openGallery(){
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }



    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }
}

// MARK: - Contact displayable

extension ContactViewController: ContactDisplayable {
    
    func display(contact: ContactDataStructure) {
        
        // TODO: - do somthing...
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table view data source

extension ContactViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isAdding {
            return 3
        } else {
            return 2
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isAdding {
            return 1
        } else {
            if section == 0 {
                return presenter?.dataSource?.phoneNumbers?.count ?? 0
            } else {
                return presenter?.dataSource?.emailAddresses?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataSource = presenter?.dataSource
        
        if isAdding {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextFieldCell.self)", for: indexPath) as? TextFieldCell
            cell?.textField.font = cell?.textLabel?.font
            
            if indexPath.section == 0 {
                cell?.textField.text = dataSource?.name
                cell?.textField.placeholder = dataSource?.namePlaceHolder
                cell?.textField.keyboardType = .namePhonePad
            } else if indexPath.section == 1 {
                cell?.textField.text = dataSource?.phoneNumbers?[indexPath.row]
                cell?.textField.placeholder = dataSource?.phonePlaceHolder
                cell?.textField.keyboardType = .phonePad
            } else {
                cell?.textField.text = dataSource?.emailAddresses?[indexPath.row]
                cell?.textField.placeholder = dataSource?.mailPlaceHolder
                cell?.textField.keyboardType = .emailAddress
            }
            
            return cell ?? UITableViewCell()
        }

        if isEditing {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextFieldCell.self)", for: indexPath) as? TextFieldCell
            cell?.textField.font = cell?.textLabel?.font
            
            if indexPath.section == 0 {
                cell?.textField.text = dataSource?.phoneNumbers?[indexPath.row]
                cell?.textField.placeholder = dataSource?.phonePlaceHolder
                cell?.textField.keyboardType = .phonePad
            } else {
                cell?.textField.text = dataSource?.emailAddresses?[indexPath.row]
                cell?.textField.placeholder = dataSource?.mailPlaceHolder
                cell?.textField.keyboardType = .emailAddress
            }
            
            return cell ?? UITableViewCell()
            
        } else {
            let cell = UITableViewCell()
            
            if indexPath.section == 0 {
                cell.textLabel?.text = presenter?.dataSource?.phoneNumbers?[indexPath.row]
            } else {
                cell.textLabel?.text = presenter?.dataSource?.emailAddresses?[indexPath.row]
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                
        if isAdding {
            return ["Name", "Phone Number", "Email Address"][section]
        } else {
            return ["Phone Numbers", "Email Addresses"][section]
        }
    }
}

// MARK: - Table view delegate

extension ContactViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard
            !isEditing,
            indexPath.section == 0,
            let phoneNumberString = presenter?.dataSource?.phoneNumbers?[indexPath.row],
            let uRL = URL(string: "tel://" + phoneNumberString)
            else { return }
        
          let application: UIApplication = UIApplication.shared
          if application.canOpenURL(uRL) {
              application.open(uRL, options: [:], completionHandler: nil)
          }
    }
}
