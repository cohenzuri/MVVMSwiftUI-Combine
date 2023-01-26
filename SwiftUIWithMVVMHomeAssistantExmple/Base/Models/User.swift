//
//  User.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/11/22.
//

// MARK: - JSON
struct UserResponse: Codable, Equatable {
    let data: User
    let support: Support
}

// MARK: - Datum
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String?
    let avatar: String

//    enum CodingKeys: String, CodingKey {
//        case id, email
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case avatar
//    }
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}

