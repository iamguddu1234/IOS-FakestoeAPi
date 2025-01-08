//
//  Admin.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 07/01/25.
//

import SwiftUI

struct Admin: View {
    
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20){
                
                NavigationLink(destination: AddProductView()){
                    Text("Add Product")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: UpdateProductView()){
                    Text("Update Product")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                NavigationLink(destination: DeleteProductView()){
                    Text("Delete Product")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                NavigationLink(destination: AddUserView()){
                    Text("Add User")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: UpdateUser()){
                    Text("Update User")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: DeleteUser()){
                    Text("Delete User")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                Spacer()
            }
            .padding()
            .navigationTitle("Admin Panel")
        }
    }
}

#Preview {
    Admin()
}
