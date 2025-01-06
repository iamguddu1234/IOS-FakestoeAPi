//
//  UserDetailView.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import SwiftUI

struct UserDetailView: View {
    
    
    let user: User
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {

            
            VStack(alignment: .leading, spacing: 10){
                
                Text(user.email)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.username)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.password)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.name.firstname)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.name.lastname)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.address.city)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.address.street)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.address.number)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.address.zipcode)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                
                Text(String(format: "%.2f", user.address.geolocation.lat))
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(String(format: "%.2f", user.address.geolocation.long))
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
                Text(user.phone)
                    .font(.largeTitle)
                    .fontWeight(.regular)
                    .padding(.top)
                
            }
            .padding()
        }
        
        .navigationBarTitle("User Details", displayMode: .inline)

    }
}

#Preview {
//    UserDetailView()
}
