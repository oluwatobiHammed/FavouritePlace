//
//  PlaceViewModel.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import Foundation
import SwiftUI

class PlaceViewModel: Identifiable {
    var id: UUID
    var name: String
    var city: String
    var country: String
    var note: String
    var placeImage: Image
    
    init(id: UUID, name: String, city: String, country: String, note: String, placeImage: Image) {
        self.id = id
        self.name = name
        self.city = city
        self.country = country
        self.note = note
        self.placeImage = placeImage
    }
}


extension PlaceViewModel {
    static var sampleData: [PlaceViewModel] {
        [
            .init(id: UUID(), name: "AlejandraSanta", city: "Alejandra", country: "Argentina", note: "ALEJANDRA (MMSI: 234845000) is a Pleasure Craft and is sailing under the flag of United Kingdom. Her length overall (LOA) is 41 meters and her width is 8 meters", placeImage: Image("alejandra")),
            .init(id: UUID(), name: "florian", city: "Cardiff", country: "Wales", note: "Located in South Wales, Cardiff is a two-hour journey from London by train. The city is also served by Cardiff Airport", placeImage: Image("florian")),
            .init(id: UUID(), name: "Eiffel Tower", city: "Paris", country: "France", note: "Have dinner at Eiffel Tower", placeImage: Image("eiffel tower"))
        ]
    }
}
