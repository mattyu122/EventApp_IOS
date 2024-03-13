//
//  Favourites.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/15/24.
//
import Foundation
import SwiftUI

struct Favourites: View {
    @State private var favouritesList : [Activity] = []
    @State private var linkSelection : Int? = nil
    var body: some View {
        NavigationStack {

            NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
           
            
//            List {
//                if !self.favouritesList.isEmpty {
//                    ForEach(self.favouritesList) {
//                        activity in
//                        
//                            ActivityRow(activity: activity)
//                        
//                        
//                    }.onDelete(perform: {
//                        indexSet in
//                        self.favouritesList.remove(atOffsets: indexSet)
//                        saveFavouritesListToUD(favouritesList: self.favouritesList)
//                    })
//                }else {
//                    Text("You do not have Favourites yet")
//                }
//            }
            .onAppear(){
                if let data = UserDefaults.standard.data(forKey: "favourites") {
                    do {
                        let decoder = JSONDecoder()
                        let favouriteActivites = try decoder.decode([Activity].self, from: data)
                        self.favouritesList = favouriteActivites
                    } catch {
                        print("Unable to get favourites")
                    }
                }
            }
            
            .background(.white)
                .navigationTitle("Favourite Things")
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
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

#Preview {
    Favourites()
}
