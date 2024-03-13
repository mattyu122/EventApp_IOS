import FirebaseFirestore

class FireDB:ObservableObject {
    static let shared = FireDB()
    
    private let db = Firestore.firestore()

    func addEventForUser(event: Event, currentUser: User) {
        let userRef = db.collection("users").document(currentUser.email)

        // Prepare the event data as a dictionary
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
        
        // Update the user's document to include the new event in the 'eventAttending' array
        // If 'eventAttending' does not exist, it will be created.
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
}
