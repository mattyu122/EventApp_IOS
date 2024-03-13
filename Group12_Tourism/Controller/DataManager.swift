//
//  DataManager.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import Foundation
import CoreLocation

class DataManager: NSObject, ObservableObject {
    static let shared = DataManager()
    private var locationManager = CLLocationManager()
    @Published var currentLocation = CLLocationCoordinate2D()

    // For demonstration purposes
    @Published var activities: [Activity] = Activity.sampleActivities
    @Published var events: [Event] = []
    
    override init() {
        super.init()
        setupLocationManager()
        currentLocation.latitude = 45.5019
        currentLocation.longitude = -73.5674
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func fetchEvents(byCity city: String) {
        if city.isEmpty{
            self.fetchEvents(near: currentLocation)
            return
        }
        self.events = []
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(city) { [weak self] (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!.localizedDescription)")
                return
            }
            
            guard let strongSelf = self, let placemark = placemarks?.first, let location = placemark.location else {
                print("No locations found")
                return
            }
            
            strongSelf.fetchEvents(near: location.coordinate)
        }
    }
    
    private func fetchEvents(near location: CLLocationCoordinate2D) {
        // Use the coordinates in your API call
        // Example API call might look something like this:
        print("location: \(location.latitude), longitude: \(location.longitude)")
        let urlString = "https://api.seatgeek.com/2/events?lat=\(location.latitude)&lon=\(location.longitude)&client_id=NDAzNjYzNjN8MTcxMDI3MTk5OS4xNzI2OTY2"
        
        
        // Proceed with creating a URLRequest and fetching the data...
        guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            // Create a URL session data task to fetch the data
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                // Handle errors
                if let error = error {
                    print("Error fetching events: \(error.localizedDescription)")
                    return
                }

                // Check for valid response and data
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response")
                    print("")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                // Decode the JSON data into our model
                do {
                    let decoder = JSONDecoder()

                    let eventResponse = try decoder.decode(EventResponse.self, from: data)
                    DispatchQueue.main.async {
                        // Now eventResponse.events contains your array of events
                        self?.events = eventResponse.events
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }

            // Start the data task
            task.resume()
    }
}

extension DataManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        fetchEvents(near: currentLocation)
    }
}

