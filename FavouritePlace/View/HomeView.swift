//
//  HomeView.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = PlacesListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30){
               topHeader()
                
                if !viewModel.places.isEmpty {
                    // placesView()
                    
                } else {
                  // emptyStateView()
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.fetchPlaces()
            }
        }
    }
    
    private func topHeader() -> some View {
        HStack {
            Text(
                """
                Oluwatobi's
                Favourite Places
                """
            )
            .font(.title)
            Spacer()
            
            Button(action: {viewModel.showAddSheet.toggle()}) {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                    .tint(Color.orange.gradient)
            }
            .sheet(isPresented: $viewModel.showAddSheet,
                   onDismiss: {
                viewModel.fetchPlaces()
            }) {
               AddNewPlaceView()
                    .presentationDetents([.large])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.ultraThinMaterial)
            }
        }
    }
}


