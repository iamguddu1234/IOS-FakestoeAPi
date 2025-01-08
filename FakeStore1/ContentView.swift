//
//  ContentView.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProductViewModel()
    @StateObject var userViewModel = UserViewModel()

    var body: some View {
        VStack {
            
            Admin()
            
//            ProductGridView(viewModel: viewModel)
            
            
        }
       
    }
}

#Preview {
    ContentView()
}
