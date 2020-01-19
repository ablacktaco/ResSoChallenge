//
//  BridgeEndPoint.swift
//  HoneyMoonBridge
//
//  Created by 陳姿穎 on 2019/12/17.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

public enum RedSoApi {
    case catalog(team:String, page: Int)
}

extension RedSoApi: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://us-central1-redso-challenge.cloudfunctions.net") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .catalog: return "catalog"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .catalog: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .catalog(let team, let page):
            return .requestWithParameters(bodyParameters: nil, urlParameters: ["team": team, "page": page])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
