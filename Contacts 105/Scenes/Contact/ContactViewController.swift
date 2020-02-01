//
//  ContactViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

import Contacts

class ContactViewController: UIViewController {
        
    var isAdding = false
    var identifier: String?
    private var presenter: ContactPresentable?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ContactPresenter(viewController: self, identifier: identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationItem.rightBarButtonItem = editButtonItem
        title = presenter?.dataSource?.name
        avatarImageView.image = presenter?.dataSource?.avatar
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        if isAdding {
            setEditing(true, animated: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if isAdding {
            
            if editing {
                let name = "TextFieldCell"
                tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
                tableView.reloadData()
               avatarLabel.textColor = .blue
            } else {
                view.endEditing(true)
                presenter?.didAdd(contact: rawContactDataStructure)
            }

        } else {
            
            if editing {
                let name = "TextFieldCell"
                tableView.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
                tableView.reloadData()
                avatarLabel.textColor = .blue
            } else {
                view.endEditing(true)
                avatarLabel.textColor = .darkText
                presenter?.didUpdate(contact: rawContactDataStructure)
            }
        }
    }
    
    @IBAction func avatarButtonPressed(_ sender: UIButton) {
        presenter?.didPressAvatarButton()
    }
}

// MARK: - Contact displayable

extension ContactViewController: ContactDisplayable {
    
    func display(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func displayImagePicker(of sourceType: UIImagePickerController.SourceType) {
        let ipc = UIImagePickerController()
        ipc.delegate = self
        ipc.sourceType = sourceType
        present(ipc, animated: true)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table view data source

extension ContactViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isAdding {
            return section == 3 ? 0 : 1
        }
        
        if isEditing {
            
            switch section {
            case 1: return presenter?.dataSource?.phoneNumbers?.count ?? 0
            case 2: return presenter?.dataSource?.emailAddresses?.count ?? 0
            default: return 1
            }
            
        } else {
            
            switch section {
            case 1: return presenter?.dataSource?.phoneNumbers?.count ?? 1
            case 2: return presenter?.dataSource?.emailAddresses?.count ?? 1
            default: return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataSource = presenter?.dataSource

        if isEditing {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TextFieldCell.self)", for: indexPath) as? TextFieldCell
            cell?.textField.font = cell?.textLabel?.font
            
            switch indexPath.section {
            case 0:
                cell?.textField.text = dataSource?.name
                cell?.textField.placeholder = dataSource?.namePlaceHolder
                cell?.textField.keyboardType = .namePhonePad
                
            case 1:
                cell?.textField.text = dataSource?.phoneNumbers?[indexPath.row]
                cell?.textField.placeholder = dataSource?.phonePlaceHolder
                cell?.textField.keyboardType = .phonePad
                
            case 2:
                cell?.textField.text = dataSource?.emailAddresses?[indexPath.row]
                cell?.textField.placeholder = dataSource?.mailPlaceHolder
                cell?.textField.keyboardType = .emailAddress
            default:
                let cell = UITableViewCell()
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = .red
                cell.textLabel?.text = "Delete contact"
                cell.imageView?.image = nil
                cell.selectionStyle = .none
                return cell
            }
            
            cell?.textField.textColor = .blue
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
            
        } else {
            
            let cell = UITableViewCell()
            
            switch indexPath.section {
            case 1: cell.textLabel?.text = dataSource?.phoneNumbers?[indexPath.row]
            case 2: cell.textLabel?.text = dataSource?.emailAddresses?[indexPath.row]
            default: () // Do nothing
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                
        if isAdding {
            return ["Name", "Phone Number", "Email Address", nil][section]
        } else {
            return [nil ,"Phone Numbers", "Email Addresses", nil][section]
        }
    }
}

// MARK: - Table view delegate

extension ContactViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isEditing {
            if indexPath.section == 3 {
                presenter?.didPressDelete()
            }
        } else {
            guard
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
}

// MARK: - Image picker controller delegate

extension ContactViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("Expected a dictionary containing an image, but was provided the following: \(info)")
            return
        }
        
        avatarImageView.image = image
    }
}

// MARK: - Navigation controller delegate

extension ContactViewController: UINavigationControllerDelegate { }

// MARK: - Helpers

private extension ContactViewController {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        bottomConstraint.constant = keyboardSize.height - safeAreaInsets.bottom
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomConstraint.constant = 0
    }
    
    var rawContactDataStructure: RawContactDataStructure {
        let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldCell
        
        let phoneNumbers = Array(0..<tableView.numberOfRows(inSection: 1))
            .map({ tableView.cellForRow(at: IndexPath(row: $0, section: 1)) as? TextFieldCell })
            .map({ $0?.textField.text })
        
        let emailAddresses = Array(0..<tableView.numberOfRows(inSection: 2))
            .map({ tableView.cellForRow(at: IndexPath(row: $0, section: 2)) as? TextFieldCell })
            .map({ $0?.textField.text })

        return RawContactDataStructure(
            identifier: identifier,
            name: nameCell?.textField.text,
            avatar: avatarImageView.image,
            phoneNumbers: phoneNumbers,
            emailAddresses: emailAddresses
        )
    }
}
