//
//  ActivityDetailsView.swift
//  Tourist_Group12
//
//  Created by Arogs on 2/13/24.
//

import SwiftUI

struct ActivityDetailsView: View {
//    var activity: Activity
    var event: Event
    @State private var rating :Int = 1
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var linkSelection : Int? = nil
    @State private var favouritesList : [Activity] = []
    @State private var showAlert : Bool = false
    @State private var alertTitle : String = ""

    var body: some View {
        NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
        ScrollView (.horizontal, showsIndicators: false){
//            HStack(alignment: .top, spacing: 0){
//                ForEach(self.activity.images, id: \.self) {
//                    image in
//                    Image(image).resizable().aspectRatio(contentMode: .fill)
//                }
//            }//HStack
//            .frame(height: 200 )
//            Spacer()
        }
        .frame(height: 200 )
        Spacer()
        VStack(alignment: .leading){
//            Text(activity.name).font(.title)
//            Text(activity.description).font(.callout)
//            
//            Text(String(format: "$%.2f", activity.price)).bold()
            HStack{
                
                Text("Tourists Rating:");
                StarRating(rating: $rating)
            }
            Spacer().frame(height: 100)
//            Text("Host: \(activity.hostedBy)")
//            let numberString = activity.phoneNumber
        
            HStack{
                Text("Contact: ")
            
//                Button(action: {
//                    viewModel.callNumber(phoneNumber: numberString)
//                   }) {
//                   Text(numberString)
//                }
            }
//                Spacer()
            
            Spacer()
        }//VStack MAin
        .position(x:120, y:250)
        .frame(maxWidth: 280)
        
        .onAppear(){
//            self.rating = activity.rating
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
//        .padding()
        HStack (spacing: 50) {
//            ShareLink(item: "\(activity.name)\n$\(activity.price)"){
//                Label("Share", systemImage: "square.and.arrow.up").foregroundColor(.appStyle)
//            }
//            Button{
//                addToFavourite(currActivity: activity)
//            }label: {
//                Image(systemName: "heart"); Text("Favourite")
//            }
//            .alert(isPresented: self.$showAlert){
//                Alert(title: Text("\(self.alertTitle)"), message: nil, dismissButton: .default(Text("Dismiss")))
//            }
//            .foregroundColor(.appStyle)
        }
        
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
    
    func addToFavourite(currActivity: Activity) {
        for activity in favouritesList {
            if activity.id == currActivity.id {
                self.alertTitle = "Activity already added"
                self.showAlert = true
                return
            }
        }
        
        favouritesList.append(currActivity)
        saveFavouritesListToUD(favouritesList: favouritesList)
        self.alertTitle = "Successfully added"
        self.showAlert = true
    }
}

//#Preview {
//    ActivityDetailsView(event: Event(), viewModel: ViewModel())
//}
