//
//  UserManager.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import Foundation

class UserManager {
    private let userDataRepository = UserDataRepository()
    
    func create(_ user: User) {
        userDataRepository.create(record: user)
    }
    
    func getAll() -> [User] {
        userDataRepository.getAll()
    }
    
    func get(byUsername username: String) -> User? {
        userDataRepository.get(byIdentifier: username)
    }
    
    func update(_ user: User) -> Bool {
        userDataRepository.update(record: user)
    }
    
    func delete(byUsername username: String) -> Bool {
        userDataRepository.delete(byIdentifier: username)
    }
    
    func checkIfExists(by username: String) -> Bool {
        guard let _ = get(byUsername: username) else {
            return false
        }
        return true
    }
}
