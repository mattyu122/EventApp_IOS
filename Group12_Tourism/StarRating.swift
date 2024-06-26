//
//  StarRating.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/15/24.
//

import SwiftUI

struct StarRating: View {
    @Binding var rating: Int
        private let maxRating = 5


        var body: some View {
            HStack {
                ForEach(1..<maxRating + 1, id: \.self) { value in
                    Image(systemName: "star")
                        .symbolVariant(value <= rating ? .fill : .none)
                        .foregroundColor(.yellow)
//                        .onTapGesture {
//                            if value != rating {
//                                rating = value
//                            } else {
//                                rating = 0
//                            }
//                        }
                }
            }
        }
}
