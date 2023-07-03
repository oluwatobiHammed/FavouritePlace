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
                     placesView()
                    
                } else {
                   emptyStateView()
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
                    .presentationCornerRadius(20)
                    .presentationBackground(.ultraThinMaterial)
            }
        }
    }
    
    private func placesView() -> some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.places) { place in
                        LazyView {
                            placesCell(place, imageMaxWidth: geo.size.width * 0.97)
                        }
                    }
                }
            }
            
        }
    }
    
    private func placesCell(_ place: PlaceViewModel, imageMaxWidth: CGFloat) -> some View {
        NavigationLink {
            LazyView {
                PlaceDetailView(place: place)
                    .edgesIgnoringSafeArea([.all])
            }
        } label: {
            ZStack(alignment: .bottom) {
                place.placeImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageMaxWidth)
                VStack {
                    Label(place.name, systemImage: "mappin.circle.fill")
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    HStack {
                        Text(place.city)
                        Spacer()
                        Text(place.country)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                }
            }
            .contentShape(Rectangle())
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
        
    }
    
    private func emptyStateView() -> some View {
        Group {
            Spacer()
            Text("Let's add some favorite places by tapping on +")
                .font(.largeTitle)
                .foregroundStyle(.secondary.opacity(0.5))
            
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: PlacesListViewModel())
            .preferredColorScheme(.dark)
    }
}
