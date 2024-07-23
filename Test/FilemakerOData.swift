//
//  FilemakerOData.swift
//  Test
//
//  Created by Simone Sarnataro on 23/07/24.
//

import Foundation

struct FileMakerODataResponse<T: Decodable>: Decodable {
    let value: T
}

