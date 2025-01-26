//
//  Untitled.swift
//  DemoApp
//
//  Created by Nitish Gadangi on 26/01/25.
//

import UIKit
import SnapKit

final class DateCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: DateCell.self)
    
    private let label: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 1
        view.textColor = .black
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func configure(number: Int, fontSize: CGFloat = 16, bgColor: UIColor = .clear) {
        label.text = "\(number)"
        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.backgroundColor = bgColor
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setup() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }
}
