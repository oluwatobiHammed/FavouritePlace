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
        places = PlaceViewModel.sampleData
    }
}
