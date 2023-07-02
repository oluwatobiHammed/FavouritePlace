//
//  UIApplication+Extension.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import Foundation
import UIKit

extension UIApplication {
    func addTapGestureRecognizer() {
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        guard let windowScene = scene as? UIWindowScene  else {return}
        guard let window = windowScene.windows.filter({$0.isKeyWindow}).first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}


extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
