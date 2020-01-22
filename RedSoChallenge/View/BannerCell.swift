//
//  BannerCell.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/14.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit
import Kingfisher

class BannerCell: UITableViewCell {
    
    @IBOutlet private var bannerImageView: UIImageView!
    
}

extension BannerCell {
    
    // TODO: modify image animation
    func setImage(_ tableView: UITableView, urlString: String) {
        let url = URL(string: urlString)
//        bannerImageView.kf.setImage(with: url) { (_) in
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
        ImageManager.shared.setImage(bannerImageView, urlString: urlString) {
            <#code#>
        }
    }
    
}
