struct UserResponse: Codable {
    let status: String
    let message: String
    let users: [User]? // Make this optional for add user case
    let user: User? // Add this field for add user case
}

//struct User: Codable, Identifiable,  Equatable {
//    let id: Int
//    let email: String
//    let username: String
//    let password: String
//    let name: Name
//    let address: Address
//    let phone: String
//    
//    
//    //EQUATABLE USE FOR PAGINATION
//    // Conform to Equatable to compare users
//    static func == (lhs: User, rhs: User) -> Bool {
//        return lhs.id == rhs.id
//    }
//}


struct User: Codable, Identifiable {
    let id: Int
    let email: String
    let username: String
    let password: String
    let name: Name
    let address: Address
    let phone: String
}

struct Name: Codable {
    let firstname: String
    let lastname: String
}

struct Address: Codable {
    let city: String
    let street: String
    let number: String
    let zipcode: String
    let geolocation: Geolocation
}

struct Geolocation: Codable {
    let lat: Double
    let long: Double
}
