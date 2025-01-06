//
//  UserList.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import SwiftUI

struct UserList: View {
    
    @StateObject private var viewModel = UserViewModel()
    @State private var userLimit = ""
    
    var body: some View {
        NavigationView {
            
            VStack{
                
                HStack {
                    TextField("Enter Users limit", text: $userLimit)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: .infinity)
                    
                    Button(action: {
                        if let limit = Int(userLimit) {
                            
                            viewModel.showLimitedUser(withLimit: limit)
                        }
                    }) {
                        Text("Show")
                            .padding(7)
                            .padding(.horizontal)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .navigationTitle("users")
                .padding()

            
                    if viewModel.isLoading{
                        ProgressView("Loading...")
                    }else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }else {
                        List(viewModel.users) { users in
                            NavigationLink(destination:UserDetailView(user: users)){
                                UsersCard(users: users)
                            }
                            
                            
                        }
                    }
                
                
                Spacer()
                
             
                
            }
            }
        .navigationTitle("users")

         
        .onAppear{
            viewModel.getAllUser()
        }
    }
}

#Preview {
    UserList()
}
