//
//  Contact.swift
//  Contacts
//
//  Created by Master IDL on 17/03/2023.
//

import Foundation

struct Contact: Codable {
    let id: Int?
    let firstname: String
    let lastname: String
    let phone: String
    let email: String
    let photo: String?
    let gender: Gender?
    
    var fullname: String {
        get {
            return "\(lastname) \(firstname)"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstname = "first_name"
        case lastname = "last_name"
        case phone = "phone_number"
        case email = "email"
        case photo
        case gender
    }
}
