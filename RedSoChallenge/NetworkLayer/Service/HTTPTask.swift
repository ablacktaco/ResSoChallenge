//
//  HTTPTask.swift
//  HoneyMoonBridge
//
//  Created by 陳姿穎 on 2019/12/17.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestWithParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestWithParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
