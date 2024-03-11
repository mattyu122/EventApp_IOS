//
//  ActivitiesScreen.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import SwiftUI

struct ActivitiesScreen: View {
    @StateObject private var dataManager = DataManager.shared
    @State private var linkSelection : Int? = nil

    var body: some View {
        NavigationStack {
            NavigationLink(destination: Favourites(), tag: 3, selection: self.$linkSelection){}
            NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
            List(dataManager.activities) { activity in
                NavigationLink(destination: ActivityDetailsView(activity: activity)) {
                    ActivityRow(activity: activity)
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
    var activity: Activity
    
    var body: some View {
        HStack(spacing: 15) {
            Image(activity.images[0])
            //Image(activity.imageName)
                        .resizable()
                        .frame(width: 75, height: 75) // Adjust size as needed
            
                    VStack(alignment: .leading, spacing: 4) {
                        Text(activity.name)
                        Text(String(format: "$%.2f/Person", activity.price))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
        
        
            }
}



#Preview {
    ActivitiesScreen()
}
