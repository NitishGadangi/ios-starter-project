//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import UIKit

public protocol ReusableView: UIView {
    func prepareForReuse()
    func didEndDisplaying()
    func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
}

// For making things optional
public extension ReusableView {
    func prepareForReuse() {}
    func didEndDisplaying() {}
    func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {}
}

public protocol ReusableCollectionViewChild: ReusableView {
    var respectiveCell: UICollectionViewCell? {get set}
}

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}
