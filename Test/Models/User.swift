//
//  User.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

struct User: Hashable, Identifiable, Codable {
    let id: String
    let name: String
    let surname: String
    let date: String
    let email: String?
    let phoneNumber: String?

    enum CodingKeys: String, CodingKey {
        case id = "idCode"
        case name = "name"
        case surname = "surname"
        case date = "dateOfBirth"
        case email = "mail"
        case phoneNumber = "phoneNumber"
    }
}
