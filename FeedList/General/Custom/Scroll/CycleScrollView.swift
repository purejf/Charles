//
//  CycleScrollView.swift
//  FeedList
//
//  Created by y on 2018/9/7.
//  Copyright © 2018年 Charles. All rights reserved.
//

import UIKit

class CycleScrollView: UIView {
    static let cellId = "cellId"

    @objc var timeInterval: TimeInterval = 4.0
    @objc var timer: Timer?
    private var index: Int = 0
    var images: [String] = [String]() {
        didSet {
            if images.count == 0 {
                pageControl.isHidden = true
            } else {
                pageControl.numberOfPages = images.count
                pageControl.isHidden = false
            }
            collectionView.reloadData()
            startTimer()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(pageControl)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var frame: CGRect {
        didSet {
            layout.invalidateLayout()
            collectionView.frame = bounds
            layout.itemSize = bounds.size
            collectionView.setCollectionViewLayout(layout, animated: false, completion: nil)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        pageControl.frame = CGRect(x: 0, y: bounds.height - 30, width: bounds.width, height: 20)
    }

    // MARK: - Timer

    private func scroll() {
        var index: Int = Int((collectionView.contentOffset.x + collectionView.bounds.width * 0.5) / collectionView.bounds.width)
        index += 1
        if index >= images.count * 1000 {
            index = images.count * 500
            collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: false)
        } else {
            collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: true)
        }
    }

    private func startTimer() {
        removeTimer()
        weak var self_ = self
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
            if let self_ = self_ {
                self_.scroll()
            }
        })
        RunLoop.current.add(timer!, forMode: .commonModes)
    }

    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Lazy

    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.pageIndicatorTintColor = UIColor.lightGray
        control.currentPageIndicatorTintColor = UIColor.red
        return control
    }()

    lazy var collectionView: UICollectionView = {
        let col = UICollectionView(frame: bounds, collectionViewLayout: layout)
        col.backgroundColor = UIColor.green
        col.showsVerticalScrollIndicator = false
        col.showsHorizontalScrollIndicator = false
        col.isPagingEnabled = true
        col.delegate = self
        col.dataSource = self
        col.scrollsToTop = false
        col.contentInsetAdjustmentBehavior = .never
        col.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CycleScrollView.cellId)
        return col
    }()

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        return layout
    }()
}

// MARK: - DataSource, Delegate

extension CycleScrollView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return images.count * 1000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleScrollView.cellId, for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        var image = cell.contentView.viewWithTag(101) as? UIImageView
        if image == nil {
            image = UIImageView()
            cell.contentView.addSubview(image!)
            cell.contentView.clipsToBounds = true
            image!.contentMode = .scaleAspectFill
            image!.mas_makeConstraints { maker in
                maker!.edges.mas_equalTo()(0)
            }
        }

        let url = URL(string: images[indexPath.row % images.count])
        image!.sd_setImage(with: url, completed: nil)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension CycleScrollView {
    func scrollViewDidScroll(_: UIScrollView) {
        var index: Int = Int((collectionView.contentOffset.x + collectionView.bounds.width * 0.5) / collectionView.bounds.width)
        index %= images.count
        pageControl.currentPage = index
    }

    func scrollViewWillBeginDragging(_: UIScrollView) {
        removeTimer()
    }

    func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {
        startTimer()
    }
}
