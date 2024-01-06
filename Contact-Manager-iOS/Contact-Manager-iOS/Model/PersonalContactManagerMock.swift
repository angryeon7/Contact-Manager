//
//  PersonalContactManagerMock.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/6/24.
//

final class PersonalContactManagerMock: PersonalContactManager {
    
    // MARK: - Properties
    private var personalContactsList: [PersonalContact] = [
        PersonalContact(name: "둘리", age: "15", contactNumber: "010-1234-1234"),
        PersonalContact(name: "길동", age: "30", contactNumber: "010-5678-5678"),
        PersonalContact(name: "도우너", age: "14", contactNumber: "010-1234-5678"),
        PersonalContact(name: "또치", age: "16", contactNumber: "010-9874-5612"),
    ]
    
    
    // MARK: - Methods
    func showUpAllPersonalContacts() -> [PersonalContact] {
        return personalContactsList
    }
    
    func addNewPersonalContact(newPersonalContact: PersonalContact) {
        personalContactsList.append(newPersonalContact)
    }
    
    func deleteSelectedPersonalContact(at index: Int) {
        personalContactsList.remove(at: index)
    }
    
    func updateSelectedPersonalContact(at index: Int, with selectedPersonalContact: PersonalContact) {
        personalContactsList[index] = selectedPersonalContact
    }
}