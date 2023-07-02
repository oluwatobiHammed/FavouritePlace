//
//  PlacesListViewModel.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import Foundation
import SwiftUI
import UIKit

class PlacesListViewModel: ObservableObject {
    
    @Published var places = [PlaceViewModel]()
    @Published var showAddSheet = false
    
    init() {
       fetchPlaces()
    }
    
    func fetchPlaces() {
        //places = PlaceViewModel.sampleData
        places = CoreDataManager.shared.getAll().map({ place in
            return PlaceViewModel(id: place.id!, name: place.name!, city: place.city!, country: place.country!, note: place.notes!, placeImage: Image(uiImage: UIImage(data: place.image!)!))

        })
    }
}
