//
//  AddContactViewController.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/12.
//

import UIKit

final class DetailContctViewController: UIViewController {
    
    //MARK: - Property
    private var contactManager: ContactManager
    private let contactDetailView: ContactDetailView = ContactDetailView()
    private var isPresentedModally: Bool = false
    var contact: Contact?
    weak var delegate: ContactDelegate?
    
    
    //MARK: - Initializer
    init(contactManager: ContactManager) {
        self.contactManager = contactManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life Cycle
    override func loadView() {
        view = contactDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContactData()
        configureNavigationBar()
    }
    
    
    //MARK: - Method
    private func configureContactData() {
        contactDetailView.contact = contact
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    private func presentCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "아니오", style: .default)
        let okAction = UIAlertAction(title: "예", style: .destructive) { [weak self] _ in
            self?.moveToContactsViewScreen()
        }
        alert.addAction(noAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func moveToContactsViewScreen() {
        if isPresentedModally {
            self.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func presentSaveFailureAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func toggleIsPresentedModally() {
        isPresentedModally = !isPresentedModally
    }
    
    //MARK: - Slector
    @objc private func cancelTapped() {
        presentCancelAlert()
    }
    
    @objc private func saveTapped() {
        let currentContactInpt: ContactInput = contactDetailView.fetchCurrentContactInput()
        if contact == nil {
            let newContact = Contact(name: currentContactInpt.name, age: currentContactInpt.age, contactNumber: currentContactInpt.contactNumber)
            
            delegate?.addNewContact(newContact: newContact)
        } else {
            if var contact = contact {
                contact.name = currentContactInpt.name
                contact.age = currentContactInpt.age
                contact.contactNumber = currentContactInpt.contactNumber
                
                contactDetailView.contact = contact
                
                delegate?.updatedContact(contactId: contact.id, with: contact)
            }
        }
        moveToContactsViewScreen()
    }
        
//        var name = currentContactInpt.name.replacingOccurrences(of: " ", with: "")
//        isValidName(name)
//        var ageString = currentContactInpt.age
//        isValidAge(ageString)
//        var contactNumber = currentContactInpt.contactNumber
//        isValidContactNumber(contactNumber)
//        
//        
//        if let name = addContactView.nameTextField.text, !isValidName(name) {
//                presentSaveFailureAlert(message: "입력한 이름 정보가 잘못되었습니다.")
//            } else if let ageString = addContactView.ageTextField.text, !isValidAge(ageString) {
//                presentSaveFailureAlert(message: "입력한 나이 정보가 잘못되었습니다.")
//            } else if let contact = addContactView.contactNumberTextField.text, !isValidContactNumber(contact) {
//                presentSaveFailureAlert(message: "입력한 연락처 정보가 잘못되었습니다.")
//            }
//            return
//        }
//        
//        let addNewContact = Contact(name: name, age: ageString, contactNumber: contactNumber)
//        delegate?.addNewContact(newContact: addNewContact)
//        dismiss(animated: true, completion: nil)
//    }
    
    private func isValidName(_ name: String) -> Bool {
        return !name.isEmpty
    }
    
    private func isValidAge(_ ageString: String) -> Bool {
        guard let age = Int(ageString), 0 < age && age <= 999,
              String(age) == ageString else {
            return false
        }
        return true
    }
    
//    private func isValidContactNumber(_ contact: String) -> Bool {
//        guard let phoneNumber = addContactView.contactNumberTextField.text?.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines),
//              phoneNumber.count >= 9,
//              contact.filter({$0 == "-"}).count == 2 else {
//            return false
//        }
//        return true
//    }
    
    
}
