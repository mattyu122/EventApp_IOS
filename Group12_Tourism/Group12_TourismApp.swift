//
//  Group12_TourismApp.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@main
struct Group12_TourismApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
