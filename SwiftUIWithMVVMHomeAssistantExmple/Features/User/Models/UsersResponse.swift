//
//  User.swift
//  SwiftUIWithMVVMHomeAssistantExmple
//
//  Created by zuri cohen on 12/5/22.
//

// https://reqres.in/api/users?page=2

import Foundation

// MARK: - JSON
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [User]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}


