//
//  CategoryViewModel.swift
//  FakeStore1
//
//  Created by Akshay Bhasme on 06/01/25.
//

import Foundation
import Combine


class CategoryViewModel: ObservableObject {
    
    @Published var categories: [String] = []
    @Published var isLoading = false
    @Published var errrorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchCategory(){
        
        let urlString = "https://fakestoreapi.in/api/products/category"
        
        guard let url = URL(string: urlString) else {
            self.errrorMessage = "Invalid url"
            return
        }
        
        isLoading = true
        errrorMessage = nil
        
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data}
            .handleEvents(receiveOutput: { data in
                if let jsonString = String(data : data, encoding: .utf8){
                    print("Recived JSON: \(jsonString)")
                // Debugging Raw Json OUTPUT
            }
            })
            .decode(type: CategoryResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.errrorMessage = "Failed to fetch users:\(error.localizedDescription)"
                    self.isLoading = false
                }
            }, receiveValue: { categoryResponse in
                self.categories = categoryResponse.categories
                self.isLoading = false
                
            })
            .store(in: &cancellables)
        
    }
    
    
}
