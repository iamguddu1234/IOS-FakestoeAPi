import SwiftUI

struct CategoryListView: View {
    
    @StateObject private var viewModel = CategoryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Categories are loading...")
                        .padding()
                } else if let errorMessage = viewModel.errrorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    // ScrollView with categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.categories, id: \.self) { category in
                                Button(action: {
                                    print("Selected Category: \(category)")
                                }) {
                                    Text(category)
                                        .font(.headline)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(height: 60) // Adjust the height of the scrollable area
                }
            }
           
//            .navigationTitle("Categories")
//            .padding(0)
            .onAppear {
                viewModel.fetchCategory()
            }
        }
        .background(Color.gray)
        .frame(height: 60)
    }
}

#Preview {
    CategoryListView()
}
