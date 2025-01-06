//
//  Product.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import Foundation


struct ProductResponse: Codable {
    let status: String
    let message: String
    let products: [Product]
}


struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let price: Double  // Changed from Int to Double
    let description: String
    let brand: String
    let model: String
    let color: String?  // Optional because it might be missing
    let category: String
    let discount: Int?
    let popular: Bool?
    let onSale: Bool?
}


