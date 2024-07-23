//
//  Rental.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

struct Rental: Hashable, Decodable {
    let bookID: UUID
    let userID: String
    let startDate: Date
    let endDate: Date

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case bookID = "bookId"
        case startDate = "dateStartRental"
        case endDate = "dateEndRental"
    }
}
