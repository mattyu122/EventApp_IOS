import Foundation

struct EventResponse: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {
    var id: Int
    var type: String
    var datetime_utc: String
    var venue: Venue
    var performers: [Performer]
    var datetime_local: String
    var short_title: String
    var url: String
    // Add other fields as needed
    var popularity: Double?
    var is_open: Bool?
    // Include any other fields you might need from the JSON
}

struct Venue: Codable {
    var state: String
    var name_v2: String
    var postal_code: String
    var name: String
    var location: Location
    var address: String
    var country: String
    var city: String
    // Include any additional fields from Venue in the JSON
}

struct Location: Codable {
    var lat: Double
    var lon: Double
}

struct Performer: Codable {
    var type: String
    var name: String
    var image: String
    // Include any additional fields from Performer in the JSON
    var popularity: Double?
    var id: Int
    // Add fields for other properties of Performer if needed
}

// Note: This is structured based on the JSON snippet you provided.
// If there are additional fields in the full JSON response not included here,
// you should add them to the corresponding structs.
