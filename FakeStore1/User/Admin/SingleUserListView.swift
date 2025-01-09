import SwiftUI

struct SingleUserListView: View {
    @StateObject var paginationViewModel = UserPaginationViewModel()  // ViewModel for pagination
    
    // User ID you want to fetch
    let userId: Int
    
    var body: some View {
        VStack {
            if paginationViewModel.isLoading {
                ProgressView("Loading user...")  // Show loading indicator while fetching user
            } else if let user = paginationViewModel.singleUser {
                // Display the fetched user information
                VStack(alignment: .leading, spacing: 10) {
                    Text("User ID: \(user.id)")
                        .font(.headline)
                    
                    Text("Name: \(user.name.firstname) \(user.name.lastname)")
                        .font(.title2)
                    
                    Text("Username: \(user.username)")
                        .font(.body)
                    
                    Text("Email: \(user.email)")
                        .font(.body)
                    
                    Text("Phone: \(user.phone)")
                        .font(.body)
                    
                    Text("Address: \(user.address.street), \(user.address.city), \(user.address.zipcode)")
                        .font(.body)
                    
                    Text("Geolocation: Lat: \(user.address.geolocation.lat), Long: \(user.address.geolocation.long)")
                        .font(.body)
                        .padding(.top, 10)
                }
                .padding()  // Add padding around the entire VStack
                .background(Color.white)  // Background color to differentiate content
                .cornerRadius(10)  // Rounded corners for the border
                .shadow(radius: 5)  // Add a shadow for a subtle 3D effect
                .padding(.horizontal)  // Horizontal padding for the entire content
//                .border(Color.gray, width: 1)
            } else {
                Text("No user found.")
                    .foregroundColor(.red)
            }
        }
        
        .onAppear {
            // Fetch the single user when the view appears
            paginationViewModel.fetchSingleUser(userId: userId)
        }
        .navigationTitle("User Details")
    }
}

#Preview {
    SingleUserListView(userId: 7)  // Test with user ID 7
}
