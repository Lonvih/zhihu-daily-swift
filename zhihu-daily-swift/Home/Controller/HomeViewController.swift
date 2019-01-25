//
//  HomeViewController.swift
//  zhihu-daily-swift
//
//  Created by showTime on 1/21/19.
//  Copyright © 2019 showTime. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var list: NewsListModel? {
        didSet {
            collectionView.reloadData()
        }
    } // 列表数据
    
    let newsCellId: String = "NewsCellView"
    let bannerCellId: String = "BannerCellView"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
        
    }()

    override func viewDidLoad() {
        self.view.addSubview(collectionView)
        super.viewDidLoad()
        self.navigationItem.title = "今日要闻"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCellView.self, forCellWithReuseIdentifier: newsCellId)
        collectionView.register(BannerView.self, forCellWithReuseIdentifier: bannerCellId)
        layoutCollectionView()
        getPageData()
//        MyRequest.get(path: ReqUrls.newsList) { (model: NewsListModel) -> Void in
//            print(model)
//        }
    }
    
    func layoutCollectionView() {
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.view).offset(0)
        }
    }
    
    func getPageData() {
        MyRequest.get(path: ReqUrls.newsList) { (model: NewsListModel) in
            self.list = model
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list?.stories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        if row == 0 {
            // 第一行使用banner
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellId, for: indexPath) as! BannerView
            if let bannerModels: [BannerModel] = list?.top_stories {
                cell.banners = bannerModels
            }
            return cell
        } else {
            // 普通cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCellId, for: indexPath) as! NewsCellView
            let row = indexPath.row - 1
            if let storyModel: StoryModel = (list?.stories[row]) {
                let text = storyModel.title!
                cell.imageView.image = ImageTools.getImageFromUrl(url: storyModel.images![0])
                cell.titleView.text = text
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        let screenSize = UIScreen.main.bounds
        if row == 0 {
            return CGSize(width: screenSize.width, height: 200)
        } else {
            return CGSize(width: screenSize.width, height: 90)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
