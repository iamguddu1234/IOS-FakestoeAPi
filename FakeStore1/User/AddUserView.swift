//
//  AddUserView.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 08/01/25.
//

import SwiftUI

import SwiftUI

struct AddUserView: View {
    
    @StateObject private var viewModel = UserViewModel()
    
    // Input fields
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var city = ""
    @State private var street = ""
    @State private var number = ""
    @State private var zipcode = ""
    @State private var lat: Double = 0.0
    @State private var long: Double = 0.0
    @State private var phone = ""
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 20)
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("First Name", text: $firstname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Last Name", text: $lastname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Street", text: $street)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Number", text: $number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Zipcode", text: $zipcode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Latitude", value: $lat, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Longitude", value: $long, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Phone", text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                Button(action: {
                    // Validate inputs
                    if email.isEmpty || username.isEmpty || password.isEmpty || firstname.isEmpty || lastname.isEmpty || city.isEmpty || street.isEmpty || number.isEmpty || zipcode.isEmpty || phone.isEmpty {
                        viewModel.errorMessage = "Please fill in all required fields."
                        return
                    }
                    
                    // Call the view model to add user
                    viewModel.addUser(
                        email: email,
                        username: username,
                        password: password,
                        firstname: firstname,
                        lastname: lastname,
                        city: city,
                        street: street,
                        number: number,
                        zipcode: zipcode,
                        lat: lat,
                        long: long,
                        phone: phone
                    )
                }) {
                    Text("Add User")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.isLoading) // Disable button while loading
                
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
            .navigationTitle("Add User")
        }
        
    }
}




#Preview {
    AddUserView()
}
