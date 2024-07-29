//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit

public extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = self.arrangedSubviews

        for subview in removedSubviews {
            self.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
