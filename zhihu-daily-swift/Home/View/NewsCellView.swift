//
//  NewsCellView.swift
//  zhihu-daily-swift
//
//  Created by showTime on 1/22/19.
//  Copyright © 2019 showTime. All rights reserved.
//

import UIKit
import SnapKit

class NewsCellView: UICollectionViewCell {
    var titleView: UILabel
    var imageView: UIImageView
    var borderBottom: UIView
    
    override init(frame: CGRect) {
        self.titleView = UILabel()
        self.imageView = UIImageView()
        self.borderBottom = UIView()
        borderBottom.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        imageView.backgroundColor = .green
        titleView.numberOfLines = 0
        titleView.sizeToFit()
        titleView.font = UIFont(name: "Helvetica", size: 14.0)
        super.init(frame: frame)
        createCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("this init method is not implemented")
    }
    
    func createCell() {
        self.backgroundColor = .white
        addSubview(titleView)
        addSubview(imageView)
        addSubview(borderBottom)
        setCellConstraints()
    }
    
    func setCellConstraints() {
        titleView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(15)
            make.right.equalTo(imageView.snp.left).offset(-15)
            make.height.equalTo(60)
        }
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(60)
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        borderBottom.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.right.equalTo(self).offset(-15)
            make.left.equalTo(self).offset(15)
            make.bottom.equalTo(self).offset(0)
        }
    }
}
