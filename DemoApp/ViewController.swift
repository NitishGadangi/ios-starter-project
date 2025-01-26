//
//  ViewController.swift
//  DemoApp
//
//  Created by Nitish Gadangi on 29/07/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let dateCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = false
        view.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseIdentifier)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.bounces = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private let detailCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = false
        view.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseIdentifier)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.bounces = false
        return view
    }()
    
    private let selectedFilter: UIView = {
        let view = UIView()
        view.alpha = 0.2
        view.backgroundColor = .gray
        return view
    }()
    
    private let randomColors: [UIColor] = (1...Constants.numOfDays).map { _ in
        return UIColor.random()
    }
    
    private var firstCellHeight: CGFloat = Constants.detailHeight
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    private func setup() {
        view.addSubview(dateCollection)
        view.addSubview(detailCollection)
        view.addSubview(selectedFilter)
        
        dateCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.dateHeight)
        }
        
        detailCollection.snp.makeConstraints { make in
            make.top.equalTo(dateCollection.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        selectedFilter.snp.makeConstraints { make in
            make.top.equalTo(dateCollection.snp.top)
            make.bottom.equalTo(dateCollection.snp.bottom)
            make.width.equalTo(Constants.dateWidth)
            make.centerX.equalToSuperview()
        }
        
        dateCollection.delegate = self
        dateCollection.dataSource = self
        detailCollection.delegate = self
        detailCollection.dataSource = self
        dateCollection.contentInset.left = Constants.dateContentInset
        dateCollection.contentInset.right = Constants.dateContentInset
        dateCollection.reloadData()
        detailCollection.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numOfDays
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as? DateCell else {
            return UICollectionViewCell()
        }
        if collectionView == dateCollection {
            cell.configure(number: indexPath.row)
        } else {
            cell.configure(number: indexPath.row, fontSize: 80, bgColor: randomColors[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dateCollection {
            return Constants.dateCellSize
        }
        return Constants.detailCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == detailCollection else { return }
        
        let visibleIndexPaths = detailCollection.indexPathsForVisibleItems
        guard let firstCellIndex = visibleIndexPaths.first,
              let firstCellAttr = detailCollection.layoutAttributesForItem(at: firstCellIndex)
        else { return }
        
        let visibleCellHeight = detailCollection.bounds.intersection(firstCellAttr.frame).height
        let actualCellHeight = firstCellAttr.frame.height
        let prevHeight = firstCellHeight
        firstCellHeight = visibleCellHeight
        
        print("idx - \(firstCellIndex.row)")
        print("vis - \(visibleCellHeight) | act - \(actualCellHeight)")
        
        let minEnterHeight = actualCellHeight - Constants.dateWidth
        let minExitHeight = Constants.dateHeight
        
        if visibleCellHeight <= minExitHeight && (prevHeight > visibleCellHeight){ // exit
            let totalWidthOfLeftCells = Constants.dateWidth * CGFloat(firstCellIndex.row) //since zero indexed
            let dx = minExitHeight - visibleCellHeight // increases
            let newOffSetforDateCollection = (-1 * dateCollection.contentInset.left) + totalWidthOfLeftCells + dx
            dateCollection.contentOffset.x = newOffSetforDateCollection
        } else if visibleCellHeight >= minEnterHeight && (prevHeight < visibleCellHeight) { // enter
            let totalWidthOfLeftCells = Constants.dateWidth * CGFloat(firstCellIndex.row) //since zero indexed
            let dx = actualCellHeight - visibleCellHeight // decreases
            let newOffSetforDateCollection = (-1 * dateCollection.contentInset.left) + totalWidthOfLeftCells + dx
            dateCollection.contentOffset.x = newOffSetforDateCollection
        }
    }
}

extension ViewController {
    enum Constants {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let datesInScreen: CGFloat = 7
        static let numOfDays: Int = 14
        static let dateWidth: CGFloat = screenWidth / datesInScreen
        static let dateHeight: CGFloat = 70
        static let dateCellSize: CGSize = .init(width: dateWidth, height: dateHeight)
        static let detailWidth: CGFloat  = screenWidth
        static let detailHeight: CGFloat = 250
        static let detailCellSize: CGSize = .init(width: detailWidth, height: detailHeight)
        static let dateContentInset: CGFloat = floor(datesInScreen/2.0) * dateWidth
    }
}
