//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
    func loadImage(fromUrl: String?) {
        guard let fromUrl else { return }
        let url = URL(string: fromUrl)
        self.kf.setImage(with: url, options: [.transition(.fade(0.5))])
    }
}
