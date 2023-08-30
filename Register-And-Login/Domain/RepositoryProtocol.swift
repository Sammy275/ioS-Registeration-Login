//
//  RepositoryProtocl.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype Record
    associatedtype Identifier
    
    func create(record: Record)
    func getAll() -> [Record]
    func get(byIdentifier: Identifier) -> Record?
    func update(record: Record) -> Bool
    func delete(byIdentifier: Identifier) -> Bool
}
