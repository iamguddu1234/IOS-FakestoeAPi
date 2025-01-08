//
//  DeleteProductView.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 07/01/25.
//

import SwiftUI

struct DeleteProductView: View {
    
    @StateObject private var viewModel = AddProductViewModel()
    
    @State private var productId = ""  // TextField for product ID
    
    var body: some View {
        VStack(spacing: 20) {
            
            // TextField for entering product ID to delete
            TextField("Enter Product ID to Delete", text: $productId)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 20)
            
            Spacer()
            
            // Button to delete the product
            Button(action: {
                // Validate if productId is entered
                if productId.isEmpty {
                    viewModel.errorMessage = "Please enter a Product ID to delete."
                    return
                }
                
                // Ensure that the product ID is a valid integer
                if let productIdInt = Int(productId) {
                    // Call deleteProduct method from ViewModel
                    viewModel.deleteProduct(productId: productIdInt)
                } else {
                    viewModel.errorMessage = "Invalid product ID"
                }
                
            }) {
                Text("Delete Product")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isSubmitting)
            
            
          
            
            // Display success message
            if let successMessage = viewModel.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }
            
            // Display error message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .navigationTitle("Delete Product")
    }
}


#Preview {
    DeleteProductView()
}
