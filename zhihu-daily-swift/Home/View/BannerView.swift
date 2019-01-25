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
    
    var banners: [BannerModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    let bannerCellId: String = "bannerCellId"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellId)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        setConstrains()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setConstrains() {
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.left.top.right.bottom.equalTo(self).offset(0)
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
        return banners?.count ?? 0
    }
    
}

class BannerCell: UICollectionViewCell {
    var imageView: UIImageView
    var titleView: UILabel
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        titleView = UILabel()
        super.init(frame: frame)
        setViewsConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setViewsConstrains() {
        addSubview(imageView)
        addSubview(titleView)
        titleView.textColor = .white
        titleView.font = UIFont.systemFont(ofSize: 21)
        titleView.numberOfLines = 2
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self).offset(0)
            make.height.equalTo(200)
        }
        titleView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-36)
        }
    }
}
