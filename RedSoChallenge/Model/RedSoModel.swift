//
//  RedSoModel.swift
//  RedSoChallenge
//
//  Created by 陳姿穎 on 2020/1/14.
//  Copyright © 2020 陳姿穎. All rights reserved.
//

import Foundation

struct RedSoModel: Codable {
    
    let results: [Result]
    
    struct Result: Codable {
        let id: String?
        let type: String
        let name: String?
        let position: String?
        let expertise: [String]?
        let avatar: String?
        let url: String?
    }
}
