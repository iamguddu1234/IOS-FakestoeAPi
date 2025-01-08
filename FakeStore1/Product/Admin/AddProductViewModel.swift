import Foundation
import Combine

class AddProductViewModel: ObservableObject {
    @Published var isSubmitting = false
    @Published var successMessage: String?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    // Function to add a product
    func addProduct(title: String, brand: String, model: String, color: String, category: String, discount: String) {
      
        
        let urlString = "https://fakestoreapi.in/api/products"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        // Prepare product data
        let productData: [String: Any] = [
            "title": title,
            "brand": brand,
            "model": model,
            "color": color,
            "category": category,
            "discount": discount // Use the converted Double here
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: productData) else {
            self.errorMessage = "Failed to encode product data"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        isSubmitting = true
        errorMessage = nil
        successMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: AddProductResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Failed: \(error.localizedDescription)"
                    self.isSubmitting = false
                }
            }, receiveValue: { response in
                // Handle response
                if response.status == "SUCCESS" {
                    self.successMessage = response.message
                    self.errorMessage = nil
                } else {
                    self.errorMessage = response.message
                    self.successMessage = nil
                }
                self.isSubmitting = false
            })
            .store(in: &cancellables)
    }

    
    // Function to delete a product
    func deleteProduct(productId: Int) {
        let urlString = "https://fakestoreapi.in/api/products/\(productId)"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set submitting state and clear previous messages
        isSubmitting = true
        errorMessage = nil
        successMessage = nil
        
        // Make network request to delete the product
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: AddProductResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Handle failure
                    self.errorMessage = "Failed: \(error.localizedDescription)"
                    self.isSubmitting = false
                }
            }, receiveValue: { response in
                if response.status == "SUCCESS" {
                    self.successMessage = response.message
                    self.errorMessage = nil
                } else {
                    self.errorMessage = response.message
                    self.successMessage = nil
                }
                self.isSubmitting = false
            })
            .store(in: &cancellables)
    }
    
 
    // Function to update product
    func updateProduct(productId: Int, title: String, brand: String, model: String, color: String, category: String, discount: String) {
        let urlString = "https://fakestoreapi.in/api/products/\(productId)"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        let updatedProductData: [String: Any] = [
            "title": title,
            "brand": brand,
            "model": model,
            "color": color,
            "category": category,
            "discount": discount
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: updatedProductData) else {
            self.errorMessage = "Failed to encode product data"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        isSubmitting = true
        errorMessage = nil
        successMessage = nil
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw server response: \(responseString)")
                }
            })
            .decode(type: AddProductResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    self.isSubmitting = false
                }
            }, receiveValue: { response in
                if response.status == "SUCCESS" {
                    self.successMessage = response.message
                } else {
                    self.errorMessage = response.message
                }
                self.isSubmitting = false
            })
            .store(in: &cancellables)
    }




    
  
}
