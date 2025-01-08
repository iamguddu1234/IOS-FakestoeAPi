//
//  UpdateUser.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 07/01/25.
//
import SwiftUI

struct UpdateUser: View {
    
    @StateObject private var viewModel = UserViewModel()
    
    @State private var userId = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var city = ""
    @State private var street = ""
    @State private var number = ""
    @State private var zipcode = ""
    @State private var lat = ""
    @State private var long = ""
    @State private var phone = ""
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            
            VStack(spacing: 20) {
                
                TextField("User ID", text: $userId)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("First Name", text: $firstname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Last Name", text: $lastname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Street", text: $street)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Number", text: $number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Zipcode", text: $zipcode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)

                TextField("Latitude", text: $lat)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)
                
                TextField("Longitude", text: $long)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)
                
                TextField("Phone", text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,1)
                
                // Update button
                Button(action: {
                    if let userIdInt = Int(userId), let latDouble = Double(lat), let longDouble = Double(long) {
                        viewModel.updateUser(id: userIdInt, email: email, username: username, password: password, firstname: firstname, lastname: lastname, city: city, street: street, number: number, zipcode: zipcode, lat: latDouble, long: longDouble, phone: phone)
                    } else {
                        viewModel.errorMessage = "Invalid data"
                    }
                }) {
                    Text("Update User")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.isLoading)
                
                if let successMessage = viewModel.successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .padding()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Update User")
            
        }
    }
}

#Preview {
    UpdateUser()
}

