//
//  APIUser.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

class Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    init(postId: Int, id: Int, name: String, email: String, body: String) {
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}
