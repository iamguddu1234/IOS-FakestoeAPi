import SwiftUI

struct UserListView: View {
    @StateObject var paginationViewModel = UserPaginationViewModel()  // ViewModel for pagination
    
    var body: some View {
        NavigationView {
            VStack {
                if paginationViewModel.isLoading && paginationViewModel.users.isEmpty {
                    ProgressView("Loading users...")  // Show loading indicator when fetching initial users
                } else {
                    List {
                        ForEach(paginationViewModel.users, id: \.id) { user in
                            UsersCard(users: user)  // Use UsersCard to display each user
                                .padding(.vertical, 10)  // Add vertical padding
                                .onAppear {
                                    // Trigger loading of more users when last user appears
                                    if let lastUser = paginationViewModel.users.last,
                                       user.id == lastUser.id {
                                        paginationViewModel.fetchUsers()  // Fetch the next page
                                    }
                                }
                        }
                        
                        // Show loading indicator at the bottom while fetching more users
                        if paginationViewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView("Loading more users...")  // Show loading text
                                Spacer()
                            }
                        }
                    }
                }
                
                // Error message display if there's any issue
                if let errorMessage = paginationViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Users")
            .onAppear {
                paginationViewModel.fetchUsers()  // Fetch the first page when the view appears
            }
        }
    }
}

#Preview {
    UserListView()
}
