//
//  UserManager.swift
//  Group12_Tourism
//
//  Created by Matt Yu on 2024-03-13.
//

import Foundation
import FirebaseFirestore

class UserManager: ObservableObject{
    static let shared = UserManager()
    private let db = FireDB.shared.db

    
    func addEventForUser(event: Event, currentUser: User) {
        let userRef = db.collection("users").document(currentUser.email)

        let eventData = [
            "id": event.id,
            "title": event.short_title,
            "performer": event.performers.first?.name ?? "N/A",
            "date": event.datetime_local,
            "venueName": event.venue.name,
            "venueAddress": event.venue.address,
            "venueCity": event.venue.city,
            "price": event.stats?.average_price ?? 0
            // Add other event details as needed
        ] as [String : Any]
        
        userRef.updateData([
            "eventsAttending": FieldValue.arrayUnion([event.id]),
            "email": currentUser.email,
            "username": currentUser.username
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated!")
            }
        }
    }

    // Add more user-related Firestore operations here
}
