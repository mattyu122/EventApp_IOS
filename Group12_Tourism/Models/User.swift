//
//  User.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import Foundation
class User :ObservableObject{
    @Published var username: String
    @Published var email: String
    @Published var password: String
    @Published var favorites: [Activity]
    @Published var attending: [Int]
    @Published var friends: [String]
    init(email: String, password: String, username: String) {
        self.email = email
        self.password = password
        self.username = username
        self.favorites = []
        self.attending = []
        self.friends = []
    }
}
