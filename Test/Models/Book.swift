//
//  Book.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

struct Book: Hashable, Identifiable, Decodable {
    let id: UUID
    let name: String
    let author: String
    let edition: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case author = "author"
        case edition = "edition"
    }
}
