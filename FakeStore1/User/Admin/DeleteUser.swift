import SwiftUI

struct DeleteUser: View {
    
    @StateObject private var viewModel = UserViewModel()
    @State private var userId = ""  // TextField for user ID
    
    var body: some View {
        VStack(spacing: 20) {
            
            // TextField for entering user ID to delete
            TextField("Enter User ID to Delete", text: $userId)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 20)
            
            Spacer()
            
            // Button to delete the user
            Button(action: {
                // Validate if userId is entered
                if userId.isEmpty {
                    viewModel.errorMessage = "Please enter a User ID to delete."
                    return
                }
                
                // Ensure that the user ID is a valid integer
                if let userIdInt = Int(userId) {
                    // Call deleteUser method from ViewModel
                    viewModel.deleteUser(userId: userIdInt)
                } else {
                    viewModel.errorMessage = "Invalid user ID"
                }
                
            }) {
                Text("Delete User")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isLoading)  // Disable button when loading
            
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
        .navigationTitle("Delete User")
    }
}

#Preview {
    DeleteUser()
}
