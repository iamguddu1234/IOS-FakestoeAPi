import Foundation
import Combine

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func getAllProduct() {
        guard let url = URL(string: "https://fakestoreapi.in/api/products") else {
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                // Use DispatchQueue.main to update UI-related properties
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load: \(error.localizedDescription)"
                    self.isLoading = false
                }
                return
            }
            
            if let data = data {
                // Log raw JSON response
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON: \(jsonString)")
                }
                
                do {
                    // Decode JSON response into ProductResponse model
                    let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.products = productResponse.products
                        self.isLoading = false
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                        self.isLoading = false
                    }
                }
            }
            
        }.resume() // Ensure you call resume() to start the URLSession task
    }
    
    func showLimitedProduct(withLimit limit: Int){
        
        let urlString = "https://fakestoreapi.in/api/products?limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
            .handleEvents(receiveOutput: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)") // Debugging: Raw JSON output
                }
            })
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed to fetched products : \(error.localizedDescription)"
                    self.isLoading = false
                }
                
            }, receiveValue: { productResponse in
                self.products = productResponse.products
                self.isLoading = false
                
            })
            .store(in: &cancellables)
        
    }
}
