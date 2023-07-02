//
//  LazyView.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
    }
}
