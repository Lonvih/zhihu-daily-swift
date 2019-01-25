//
//  ImageTools.swift
//  zhihu-daily-swift
//
//  Created by showTime on 1/25/19.
//  Copyright © 2019 showTime. All rights reserved.
//

import UIKit

class ImageTools {
    static func getImageFromUrl(url: String) -> UIImage {
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        return image!
    }
}
