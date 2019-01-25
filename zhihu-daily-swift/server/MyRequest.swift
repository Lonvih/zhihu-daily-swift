//
//  Request.swift
//  zhihu-daily-swift
//
//  Created by showTime on 1/22/19.
//  Copyright © 2019 showTime. All rights reserved.
//

import Foundation
import Alamofire

class MyRequest {
    static func get<T: Codable>(path: String, cb: @escaping (T) -> Void) {
        Alamofire.request(path).responseJSON { (response) in
            let model: T = try! JsonDecoder.decoder.decode(T.self, from: response.data!)
            cb(model)
        }
    }
}
