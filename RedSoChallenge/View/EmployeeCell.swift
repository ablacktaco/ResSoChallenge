//
//  DataCell.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/11.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet private var employeeImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var positionLabel: UILabel!
    @IBOutlet private var expertiseLabel: UILabel!
    
}

extension EmployeeCell {
    
    func setData(_ data: RedSoModel.Result) {
        nameLabel.text = data.name
        positionLabel.text = data.position
        expertiseLabel.text = setExpertise(data.expertise!)
        setImage(data.avatar!)
    }
    
    fileprivate func setExpertise(_ data: [String]) -> String {
        var employeeExpertise: String = ""
        
        data.forEach({ (expertise) in
            employeeExpertise += "\(expertise), "
        })
        employeeExpertise.removeLast(2)
        
        return employeeExpertise
    }
    
    fileprivate func setImage(_ urlString: String) {
        ImageManager.shared.setImage(employeeImageView, urlString: urlString)
        employeeImageView.layer.cornerRadius = employeeImageView.frame.width / 2
        employeeImageView.clipsToBounds = true
    }
    
}
