//
//  UserRepository.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import Foundation

struct UserDataRepository: RepositoryProtocol {
    private static let modelName = "UserData"
    
    func create(record: User) {
        let userDictionary: Dictionary<String, String> = [
            "id": record.id.uuidString,
            "username": record.username,
            "email": record.email,
            "password": record.password
        ]
        
        if let userArray = UserDefaults.standard.array(forKey: UserDataRepository.modelName)
        {
            var updatedArray = userArray
            updatedArray.append(userDictionary)
            
            UserDefaults.standard.set(updatedArray, forKey: UserDataRepository.modelName)
        }
        else {
            UserDefaults.standard.set([userDictionary], forKey: UserDataRepository.modelName)
        }
    }
    
    func getAll() -> [User] {
        if let userArray = UserDefaults.standard.array(forKey: UserDataRepository.modelName)
        {
            return userArray.map { userData in
                let userDictionary = userData as! Dictionary<String, String>
                
                return User(id: UUID(uuidString: userDictionary["id"]!)!, email: userDictionary["username"]!, username: userDictionary["email"]!, password: userDictionary["password"]!)
            }
        }
        else {
            return []
        }
    }
    
    func get(byIdentifier username: String) -> User? {
        guard let userArray = UserDefaults.standard.array(forKey: UserDataRepository.modelName) else {
            return nil
        }
        
        guard let foundUser = userArray.first(where: { userData in
            let userDictionary = userData as! Dictionary<String, String>
            let storedUserName = userDictionary["username"]!
            
            return username == storedUserName
        }) as? Dictionary<String, String>
        else {
            return nil
        }
        
        return User(id: UUID(uuidString: foundUser["id"]!)!, email: foundUser["email"]!, username: foundUser["username"]!, password: foundUser["password"]!)
    }
    
    func update(record: User) -> Bool {
        guard var userArray = UserDefaults.standard.array(forKey: UserDataRepository.modelName) else {
            return false
        }
        
        guard let indexOfUserToUpdate = userArray.firstIndex(where: { userData in
            let userDictionary = userData as! Dictionary<String, String>
            let currentUserName = userDictionary["username"]!
            
            return currentUserName == record.username
        }) else {
            return false
        }
        
        var userToUpdate = userArray[indexOfUserToUpdate] as? Dictionary<String, String>
        userToUpdate!["email"] = record.email
        userToUpdate!["password"] = record.password
        
        userArray.remove(at: indexOfUserToUpdate)
        userArray.append(userToUpdate!)
        
        
        return true
    }
    
    func delete(byIdentifier username: String) -> Bool {
        guard let userArray = UserDefaults.standard.array(forKey: UserDataRepository.modelName) else {
            return false
        }
        
        guard let indexOfUserToDelete = userArray.firstIndex(where: { userData in
            let userDictionary = userData as! Dictionary<String, String>
            let currentUserName = userDictionary["username"]!
            
            return currentUserName == username
        }) else {
            return false
        }
        
        var updatedArray = userArray
        updatedArray.remove(at: indexOfUserToDelete)
        
        
        UserDefaults.standard.set(updatedArray, forKey: UserDataRepository.modelName)
        return true
    }
    
    typealias Record = User
    typealias Identifier = String
}
