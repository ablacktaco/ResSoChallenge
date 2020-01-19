//
//  EndPointType.swift
//  HoneyMoonBridge
//
//  Created by 陳姿穎 on 2019/12/17.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
