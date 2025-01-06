import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []          // Users data
    @Published var isLoading = false           // Loading state
    @Published var errorMessage: String?       // Error message if any
    
    private var cancellables = Set<AnyCancellable>()
    
    func getAllUser() {
        guard let url = URL(string: "https://fakestoreapi.in/api/users") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to load users: \(error.localizedDescription)"
                        self.isLoading = false
                    }
                }
            }, receiveValue: { response in
                DispatchQueue.main.async {
                    self.users = response.users
                    self.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
    
    func showLimitedUser(withLimit limit: Int) {
        let urlString = "https://fakestoreapi.in/api/users?limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)") // Debugging: Raw JSON output
                }
            })
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to fetch users: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }, receiveValue: { userResponse in
                self.users = userResponse.users
                self.isLoading = false
            })
            .store(in: &cancellables) // Ensure to store the subscription
    }

}
