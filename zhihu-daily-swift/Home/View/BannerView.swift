//
//  BannerView.swift
//  zhihu-daily-swift
//
//  Created by showTime on 1/22/19.
//  Copyright © 2019 showTime. All rights reserved.
//

import UIKit

class BannerView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.bounds
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: screenSize.width, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    let pageControll: UIPageControl = UIPageControl()
    
    var banners: [BannerModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    let bannerCellId: String = "bannerCellId"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func initViews() {
        addSubview(collectionView)
        addSubview(pageControll)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellId)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.left.top.right.bottom.equalTo(self).offset(0)
        }
        pageControll.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellId, for: indexPath) as! BannerCell
        let row = indexPath.row
        let banner = banners![row]
        
        let title = banner.title!
        cell.imageView.image = ImageTools.getImageFromUrl(url: banner.image!)
        cell.titleView.text = title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = banners?.count ?? 0
        pageControll.numberOfPages = count
        return count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let curPage = Int(scrollView.contentOffset.x) / Int(collectionView.frame.width)
        pageControll.currentPage = curPage
    }
}

class BannerCell: UICollectionViewCell {
    var imageView: UIImageView
    var titleView: UILabel
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        titleView = UILabel()
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func initViews() {
        addSubview(imageView)
        addSubview(titleView)
        titleView.textColor = .white
        titleView.font = UIFont.systemFont(ofSize: 21)
        titleView.numberOfLines = 0
        titleView.sizeToFit()
        imageView.contentMode = .scaleAspectFill
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self).offset(0)
            make.height.equalTo(self)
        }
        titleView.snp.makeConstraints { (make) in
            make.height.lessThanOrEqualTo(30)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-36)
        }
    }
}
