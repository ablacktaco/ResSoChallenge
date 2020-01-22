//
//  RedSoModel.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/14.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import Foundation
import UIKit

struct RedSoModel: Codable {
    
    var results: [Result]
    
    struct Result: Codable {
        let id: String?
        let type: String
        let name: String?
        let position: String?
        let expertise: [String]?
        let avatar: String?
        let url: String?
        var imageData: Data?
        
        var imageString: String? {
            return cellImage == .avatar ? avatar : url
        }
        
        var urlRequest: URLRequest {
            let strURL = cellImage == .url ? url : avatar
            return .init(url: URL(string: strURL!)!)
        }
        
        var cellImage: ImageType {
            if avatar != nil { return .avatar }
            return .url
        }
    }
}

enum ImageType {
    case avatar
    case url
}
