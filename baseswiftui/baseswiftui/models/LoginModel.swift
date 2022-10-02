//
//  LoginModel.swift
//  baseswiftui
//
//  Created by Hai Dev on 02/10/2022.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let accessToken, refreshToken: String?
//    let user: User?
}

// MARK: - User
struct User: Codable {
    let id, email, name, createdAt: String?
    let updatedAt: String?
    let v: Int?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, name, createdAt, updatedAt
        case v = "__v"
        case avatar
    }
}
