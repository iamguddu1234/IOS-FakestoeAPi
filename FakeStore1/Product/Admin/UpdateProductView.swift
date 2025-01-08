import SwiftUI

struct UpdateProductView: View {
    @StateObject private var viewModel = AddProductViewModel()
    
    @State private var productId = ""
    @State private var title = ""
    @State private var brand = ""
    @State private var model = ""
    @State private var color = ""
    @State private var category = ""
    @State private var discount = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Product ID", text: $productId)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 20)
            
            TextField("Product Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Brand", text: $brand)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Model", text: $model)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Color", text: $color)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Category", text: $category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Discount", text: $discount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            Button(action: {
                // Validate required fields
                if title.isEmpty || brand.isEmpty || model.isEmpty || category.isEmpty || discount.isEmpty || productId.isEmpty {
                    viewModel.errorMessage = "Please fill in all required fields."
                    return
                }
                
                if let productIdInt = Int(productId) {
                    viewModel.updateProduct(productId: productIdInt, title: title, brand: brand, model: model, color: color, category: category, discount: discount)
                } else {
                    viewModel.errorMessage = "Please enter a valid product ID."
                }
            }) {
                Text("Update Product")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isSubmitting ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isSubmitting)
            
            if let successMessage = viewModel.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .navigationTitle("Update Product")
    }
}

struct UpdateProductView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProductView()
    }
}
