//
//  NewsListModel.swift
//  zhihu-daily-swift
//
//  Created by showTime on 1/22/19.
//  Copyright © 2019 showTime. All rights reserved.
//

import Foundation

struct NewsListModel: Codable {
//    var date: String?
    var stories: [StoryModel]
    var top_stories: [BannerModel]?
}

struct StoryModel: Codable {
    var ga_prefix: String?
    var id: Int?
    var images: [String]?
    var title: String?
    var type: Int?
}

struct BannerModel: Codable {
    var image: String?
    var type: Int?
    var id: Int?
    var title: String?
}
