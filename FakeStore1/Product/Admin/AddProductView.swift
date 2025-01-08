import SwiftUI

struct AddProductView: View {
    
    @StateObject private var viewModel = AddProductViewModel()
    
    @State private var title = ""
    @State private var brand = ""
    @State private var model = ""
    @State private var color = ""
    @State private var category = ""
    @State private var discount = ""  // Discount as a string, no conversion to Double
    
    var body: some View {
        VStack(spacing: 20) {
            
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
            
            TextField("Discount (Required)", text: $discount)
                .keyboardType(.decimalPad)  // Allow decimal input for discount
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            Button(action: {
                // Validate if required fields are filled
                if title.isEmpty || brand.isEmpty || model.isEmpty || category.isEmpty || discount.isEmpty {
                    viewModel.errorMessage = "Please fill in all required fields."
                    return
                }
                
                // Send discount as a string directly
                viewModel.addProduct(title: title, brand: brand, model: model, color: color, category: category, discount: discount)
                
            }) {
                Text("Add Product")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isSubmitting)  // Disable the button while submitting
            
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
        .navigationTitle("Add New Product")
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
