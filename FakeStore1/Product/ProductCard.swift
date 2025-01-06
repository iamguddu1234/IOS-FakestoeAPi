//
//  ProductCard.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import SwiftUI

struct ProductCard: View {
    
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            AsyncImage(url: URL(string: product.image)) { phase in
                
                if let image = phase.image {
                    
                    // Image at the top
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }else{
                    Color.gray
                        .frame(height: 100)
                        .cornerRadius(10)
                }
                
            }

            // Name below the image
            Text(product.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.tail)

            // Price below the name
            Text(String(format : "$%.2f", product.price))
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
            
          
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.white)
                .shadow(radius: 1)
        )
        .frame(width: 180)
    }
}





