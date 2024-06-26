//
//  saveFavouritesListToUD.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/15/24.
//

import Foundation

func saveFavouritesListToUD (favouritesList : [Activity]) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(favouritesList)
        UserDefaults.standard.set(data, forKey: "favourites")
    } catch {
        print("Unable to get store favourite default")
    }
}
