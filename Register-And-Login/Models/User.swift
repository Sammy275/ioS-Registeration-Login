//
//  User.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import Foundation

class User {
    let id: UUID
    var email: String
    var username: String
    var password: String
    
    init(id: UUID, email: String, username: String, password: String) {
        self.id = id
        self.email = email
        self.username = username
        self.password = password
    }
}
