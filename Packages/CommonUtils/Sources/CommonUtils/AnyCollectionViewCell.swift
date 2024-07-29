//
//  File.swift
//  
//
//  Created by Nitish Gadangi on 09/07/24.
//

import UIKit
import SnapKit

/// Usage
/// typealias ExampleCell = AnyTableViewCell<ExampleView>
/// regisetering -> tableView.register(ExampleCell.self)
/// dequeue with ExampleCell.
final public class AnyCollectionViewCell<View: ReusableView>: UICollectionViewCell {

    public let wrappedView: View = View()

    public override func prepareForReuse() {
        super.prepareForReuse()
        wrappedView.prepareForReuse()
    }

    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        wrappedView.apply(layoutAttributes)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addWrappedView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addWrappedView()
    }

    public func didEndDisplaying() {
        wrappedView.didEndDisplaying()
    }
}

private extension AnyCollectionViewCell {

    func addWrappedView() {
        contentView.addSubview(wrappedView)

        if let wrappedView = wrappedView as? ReusableCollectionViewChild {
            wrappedView.respectiveCell = self
        }

        wrappedView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
