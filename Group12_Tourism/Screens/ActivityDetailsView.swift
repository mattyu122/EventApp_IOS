import SwiftUI
import MapKit

struct ActivityDetailsView: View {
    @StateObject private var dataManager = DataManager.shared
    @StateObject private var userManager = UserManager.shared
    @EnvironmentObject var currentUser: User
    var event: Event
    @State private var userAttending = false
    // Initially set the region to a default value or event's location
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        ScrollView {
            Map(coordinateRegion: $region,
                annotationItems: [event.venue]) { venue in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lon), tint: .red)
            }
            .frame(height: 300)
            .onAppear {
                region.center = CLLocationCoordinate2D(latitude: self.event.venue.location.lat, longitude: self.event.venue.location.lon)
                
                dataManager.fetchEvent(byId: event.id){
                    result in
                    switch result {
                    case . success(let event):
                        print("Fetched event by ID: \(event.short_title)")
                        
                    case .failure(let error):
                        print("Error fetching event: \(error)")
                    }
                                        
                }
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(event.short_title)
                    .font(.title)
                Text("Performer: \(event.performers.first?.name ?? "N/A")")
                Text("Date: \(event.datetime_local)")
                Text("Venue: \(event.venue.name), \(event.venue.address), \(event.venue.city)")
                // Add pricing details if available
                Text("Price: \(event.stats?.average_price != nil ? "$"+String(event.stats!.average_price!) : "N/A")")
                Toggle("Attend this event", isOn: $userAttending)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .onChange(of: userAttending) { newValue in
                        if newValue {
                            // Replace "userId" with the actual user identifier
                            userManager.addEventForUser(event: event, currentUser: currentUser)
                        }
                        // Add logic for when a user is no longer attending an event if necessary
                    }

                // Implement saving functionality or API call to mark attendance
            }
            .padding()
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
