//
//  ProductListView.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        NavigationView{
            if viewModel.isLoading{
                ProgressView("Loading...")
            }else if let errorMessage = viewModel.errorMessage{
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }else {
                List(viewModel.products) { product in
                    ProductCard(product: product)
                }
                .navigationTitle("Products")
            }
        }
        .onAppear{
            viewModel.getAllProduct()
        }
    }
}

#Preview {
    ProductListView()
}
