//
//  ImageManager.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/20.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import Kingfisher
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    // TODO: modify func setImage()
    // kingfisher api
    func setImage(_ imageView: UIImageView, urlString: String, completion: (() -> Void)? = nil) {
        let url = URL(string: urlString)
        imageView.kf.setImage(with: url) { (_) in
            completion
        }
    }
    
}
