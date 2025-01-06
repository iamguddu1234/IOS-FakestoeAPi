//
//  UsersCard.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import SwiftUI

struct UsersCard: View {
    
    let users: User
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
           
            
     
            Text(users.address.number)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
            
      
            Text("\(users.name.firstname) \(users.name.lastname)")
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.tail)
       
            Text(users.email)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.tail)
            
            
        }
       
    }
}

//#Preview {
//    UsersCard(users: User(id: 1, email: "akshay@gmail.com", username: "akshay123", password: "password", name: Name(firstname: "Akshay", lastname: "Bhasme"), address: Address(city: "Mumbai", street: "Street 1", number: "101", zipcode: "400001", geolocation: [Geolocation(lat: 19.0760, long: 72.8777)]), phone: "123-456-7890"))
//
//
//
//}
              
             
