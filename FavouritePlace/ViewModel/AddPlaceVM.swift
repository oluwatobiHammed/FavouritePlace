//
//  AddPlaceVM.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import SwiftUI
import UIKit
class AddPlaceVM: ObservableObject {
    // textfield props
    @Published var name: String = ""
    @Published var city: String = ""
    @Published var country: String = ""
    @Published var notes: String = ""
    
    // progress pros
    @Published var showProgress = false
    
    // Image related props
    @Published var image: Image?
    @Published var imageData: Data?
    
    func savePlace() async {
        // core data manager save place logic
        if let imageData {
            CoreDataManager.shared.save(name: name, notes: notes, city: city, country: country, imageData: imageData)
        }
        
    }
    
    func getImageFor(placeName: String) async {
        let encodedName = placeName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!        
        let url = URL(string: "https://source.unsplash.com/1080x1350/?\(encodedName)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                imageData = data
                guard let loadedImage = UIImage(data: data) else { return }
                image = Image(uiImage: loadedImage)
            }
        } catch {
            
        }
    }
}

