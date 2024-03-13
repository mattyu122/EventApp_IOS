import Foundation

// Define the root structure
struct Event: Codable, Identifiable {
    let stats: Stats
    let title: String
    let url: String
    let datetimeLocal: Date
    let performers: [Performer]
    let venue: Venue
    let shortTitle: String
    let datetimeUtc: Date
    let score: Double
    let taxonomies: [Taxonomy]
    let type: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case stats, title, url, performers, venue, score, taxonomies, type, id
        case datetimeLocal = "datetime_local"
        case shortTitle = "short_title"
        case datetimeUtc = "datetime_utc"
    }
}

// Define nested structures
struct Stats: Codable {
    let listingCount: Int
    let averagePrice: Int
    let lowestPrice: Int
    let highestPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case listingCount = "listing_count"
        case averagePrice = "average_price"
        case lowestPrice = "lowest_price"
        case highestPrice = "highest_price"
    }
}

struct Performer: Codable, Identifiable {
    let name: String
    let shortName: String
    let url: String
    let image: String?
    let images: PerformerImages?
    let primary: Bool?
    let id: Int
    let score: Int
    let type: String
    let slug: String
    
    enum CodingKeys: String, CodingKey {
        case name, url, image, images, primary, id, score, type, slug
        case shortName = "short_name"
    }
}

struct PerformerImages: Codable {
    let large: String
    let huge: String
    let small: String
    let medium: String
}

struct Venue: Codable, Identifiable {
    let city: String
    let name: String
    let extendedAddress: String?
    let url: String
    let country: String
    let state: String
    let score: Double
    let postalCode: String
    let location: Location
    let address: String?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case city, name, url, country, state, score, location, address, id
        case extendedAddress = "extended_address"
        case postalCode = "postal_code"
    }
}

struct Location: Codable {
    let lat: Double
    let lon: Double
}

struct Taxonomy: Codable, Identifiable {
    let parentId: Int?
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case parentId = "parent_id"
        case id, name
    }
}
