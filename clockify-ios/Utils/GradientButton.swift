//
//  UIExtension.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 06/10/23.
//

import UIKit

extension UIView {

    @discardableResult
    func applyGradient(colours: [UIColor], cornerRadius:CGFloat) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil, cornerRadius: cornerRadius)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, cornerRadius: CGFloat) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
