//
//  ProductDetailView.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        VStack {
            // Product image
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading){
                
                Text(product.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Text(product.description)
                    .font(.body)
                    .padding()
                
                Text("Price: $\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.top)

                // Additional details like brand, category, etc.
                Text("Brand: \(product.brand)")
                Text("Model: \(product.model)")
    //            Text("Color: \(product.color)")
                Text("Category: \(product.category)")
            }
       
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Product Details", displayMode: .inline)
    }
}
