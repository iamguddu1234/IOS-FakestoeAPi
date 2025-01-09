import Foundation
import Combine

class UserPaginationViewModel: ObservableObject {
    @Published var users: [User] = []           // Store users
    @Published var isLoading = false            // Loading state
    @Published var errorMessage: String?        // Error messages
    @Published var currentPage = 1              // Current page for pagination
    @Published var isLastPage = false           // Last page flag
    
    @Published var singleUser: User? = nil      // Store the single fetched user

    
    private var cancellables = Set<AnyCancellable>()
    private let limit = 20                      // Limit users per page
    
    // Fetch users for the current page
    func fetchUsers() {
        guard !isLoading, !isLastPage else { return }
        
        let urlString = "https://fakestoreapi.in/api/users?page=\(currentPage)&limit=\(limit)"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        print("Fetching users for page: \(self.currentPage)")  // Debug: log current page
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                        self.isLoading = false
                    }
                case .finished:
                    break
                }
            }, receiveValue: { response in
                DispatchQueue.main.async {
                    if let fetchedUsers = response.users, !fetchedUsers.isEmpty {
                        self.users.append(contentsOf: fetchedUsers)  // Append fetched users
                        self.currentPage += 1  // Move to the next page for pagination
                        
                        print("Fetched users count: \(fetchedUsers.count)")  // Debug: log fetched users count
                        
                        // If we fetched fewer users than the limit, it's the last page
                        if fetchedUsers.count < self.limit {
                            self.isLastPage = true
                        }
                    } else {
                        // If no users are returned, mark it as the last page
                        self.isLastPage = true
                    }
                    
                    print("Is last page: \(self.isLastPage)")  // Debug: log if it's the last page
                    self.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
    
    // Fetch a single user by ID
    func fetchSingleUser(userId: Int) {
        let urlString = "https://fakestoreapi.in/api/users/\(userId)"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            print("Invalid URL: \(urlString)")  // Debugging: log invalid URL
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { response in
                print("Response data: \(response.data)")  // Debugging: print raw response data
                return response.data
            }
            .decode(type: UserResponse.self, decoder: JSONDecoder())  // Decode into UserResponse
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to load user: \(error.localizedDescription)"
                        self.isLoading = false
                        print("Error fetching user: \(error.localizedDescription)")  // Debugging: log error
                    }
                case .finished:
                    break
                }
            }, receiveValue: { userResponse in
                DispatchQueue.main.async {
                    // Set the fetched user
                    self.singleUser = userResponse.user  // Access the 'user' field from the response
                    self.isLoading = false
                    print("Successfully fetched user: \(userResponse.user)")  // Debugging: log fetched user
                }
            })
            .store(in: &cancellables)
    }


}
