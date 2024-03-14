//
//  ActivitiesScreen.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import SwiftUI

struct ActivitiesScreen: View {
    @StateObject private var dataManager = DataManager.shared
    @EnvironmentObject var currentUser: User
    @State private var linkSelection : Int? = nil
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            NavigationLink(destination: Favourites(), tag: 3, selection: self.$linkSelection){}
            NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
            List {
                TextField("Search by City", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchText, perform: { newValue in
                        dataManager.fetchEvents(byCity: newValue)
                    })
                
                ForEach(dataManager.events) { event in
                    NavigationLink(destination: ActivityDetailsView(event: event)) {
                        ActivityRow(event: event)
                    }
                }
            }
            .background(.white)
            .navigationTitle("Things To Do")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        Button{
                                self.linkSelection = 3
                            } label:{
                                Text("Favourites")
                            }
                        
                        Button{
                                logout()
                                self.linkSelection = 2
                            } label:{
                                Text("Logout")
                            }
                            
                        }//Menu
                        label: {
                            Image(systemName: "list.bullet")
                        }
                    }
            }
        }
    }
    
    
}

struct ActivityRow: View {
    var event: Event
    var body: some View {
        HStack(spacing: 15) {
            
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.short_title)
                            .font(.body)
                        Text("\(event.venue.city)-\(event.venue.address)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
        
        
            }
}



#Preview {
    ActivitiesScreen()
}
