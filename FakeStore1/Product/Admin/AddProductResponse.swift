//
//  AddProductResponse.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 08/01/25.
//

import Foundation

// Response structure for Add Product API response
struct AddProductResponse: Codable {
    let status: String
    let message: String
    let product: AddProduct?
}

// Product structure for product data
struct AddProduct: Codable, Identifiable {
//    var id: Int = 0 // Default value for id, if not provided
    var id: Int // Default value for id, if not provided
    var title: String
    var image: String? // Optional image, as it might not be provided
    var price: Double? = 0.0 // Default value for price
    var description: String? // Optional description
    var brand: String
    var model: String
    var color: String? // Optional color
    var category: String
    var discount: String // Default value for discount
    var popular: Bool? // Optional field for 'popular'
    var onSale: Bool? // Optional field for 'onSale'
    
    
    
    // Custom decoding for handling both string and integer IDs in the response
    enum CodingKeys: String, CodingKey {
        case id, title, image, price, description, brand, model, color, category, discount, popular, onSale
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the ID as an integer if possible, otherwise as a string
        if let idInt = try? container.decode(Int.self, forKey: .id) {
            self.id = idInt
        } else {
            let idString = try container.decode(String.self, forKey: .id)
            if let idInt = Int(idString) {
                self.id = idInt
            } else {
                throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "ID is not a valid integer or string")
            }
        }
        
        title = try container.decode(String.self, forKey: .title)
        image = try? container.decode(String.self, forKey: .image)
        price = try? container.decode(Double.self, forKey: .price)
        description = try? container.decode(String.self, forKey: .description)
        brand = try container.decode(String.self, forKey: .brand)
        model = try container.decode(String.self, forKey: .model)
        color = try? container.decode(String.self, forKey: .color)
        category = try container.decode(String.self, forKey: .category)
        discount = try container.decode(String.self, forKey: .discount)
        popular = try? container.decode(Bool.self, forKey: .popular)
        onSale = try? container.decode(Bool.self, forKey: .onSale)
    }
   
}
    


