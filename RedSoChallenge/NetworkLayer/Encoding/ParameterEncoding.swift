//
//  ParameterEncoding.swift
//  HoneyMoonBridge
//
//  Created by 陳姿穎 on 2019/12/17.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFail = "Parameters encoding failed."
    case missingURL = "URL is nil."
}
