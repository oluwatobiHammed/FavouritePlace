//
//  AddNewPlaceView.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import SwiftUI

struct AddNewPlaceView: View, KeyboardReadable {
    
    @Environment(\.dismiss) var dismiss
    @State private var isKeyboardVisible = false
    
    @StateObject var viewModel = AddPlaceVM()
    @State var isEditing: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height:  isKeyboardVisible ? 120 : 20)
                Text("New Favourite Place")
                    .font(.title)
                Group {
                    TextField("Name of Place", text: $viewModel.name)
                    TextField("City", text: $viewModel.city)
                    TextField("Country", text: $viewModel.country)
                    TextField("Note", text: $viewModel.notes)
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onTapGesture {
                    isEditing  = true
                }
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                             print("Is keyboard visible? ", newIsKeyboardVisible)
                             isKeyboardVisible = newIsKeyboardVisible
                         }
                Spacer()
                    .frame(height: 25)
                if let image = viewModel.image {
                    image
                        .resizable()
                        .frame(width: 200, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Image("redd-f")
                        .resizable()
                        .blur(radius: 30)
                        .frame(width: 200, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Spacer()
                    .frame(height: 20)
                Button("Get Image") {
                    Task {
                        await viewModel.getImageFor(placeName: viewModel.name)
                        hideKeyboard()
                    }
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .disabled(viewModel.name.isEmpty)
                
                Spacer()
                    .frame(width: 5)
                HStack {
                    Button(action: {
                         savePlace()
                    }, label: {
                        Label("Save", systemImage: "doc.fill.badge.plus")
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Label("Cancel", systemImage: "x.square.fill")
                    }
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
                
            }.ignoresSafeArea(.keyboard, edges: .bottom)
            
            if viewModel.showProgress {
                Rectangle()
                    .foregroundStyle(Color.secondary.opacity(0.8))
                ProgressView {
                    Text("Saving new place...")
                }
            }
        }
        .interactiveDismissDisabled()
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
      
    }
    
   
    
    private func savePlace() {
        // all the logive for saving the place
        dismiss()
        
    }

}

//#Preview {
//    AddNewPlaceView()
//        .padding(.all)
//        .preferredColorScheme(.dark)
//    
//}

