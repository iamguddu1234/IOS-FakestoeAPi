//
//  CategoryResponse.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import Foundation

struct CategoryResponse: Codable {
    let status : String
    let message: String
    let categories: [String]
}
