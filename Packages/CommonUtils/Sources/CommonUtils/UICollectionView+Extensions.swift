//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import Foundation
import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

// For Reusable view extensions
extension UICollectionReusableView: Reusable {
    @objc public class var reuseIdentifier: String {
        return String(describing: self)
    }
}
