import SwiftUI

struct ProductGridView: View {
    @ObservedObject var viewModel: ProductViewModel
    
    @State private var productLimit = ""
    
    // Define the layout: two equally spaced columns
    let columns = [
        GridItem(.flexible()), // First column
        GridItem(.flexible())  // Second column
    ]
    
    var body: some View {
        
        NavigationView{
            
            VStack{
               
                // TextField and Button in HStack
                HStack {
                    TextField("Enter product limit", text: $productLimit)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: .infinity)
                    
                    Button(action: {
                        if let limit = Int(productLimit) {
                         
                            viewModel.showLimitedProduct(withLimit: limit)
                        }
                    }) {
                        Text("Show")
                            .padding(7)
                            .padding(.horizontal)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding([.horizontal, .top], 10) // Adjust padding for HStack

                CategoryListView()
                    .padding([.horizontal], 10)  // Optional: Add horizontal padding only

                
                   
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    if viewModel.isLoading {
                        ProgressView() // Loading indicator
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    } else {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    
                                    ProductCard(product: product)
                                        .padding(10)  // Remove padding around each product card
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 10) // Optional: Add horizontal padding around the grid
                        
                        
                    }
                    
                }
                .onAppear {
                    viewModel.getAllProduct()
                }
            }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}

#Preview {
//    ProductGridView(viewModel: viewModel)
}
