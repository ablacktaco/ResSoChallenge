//
//  NetworkManager.swift
//  HoneyMoonBridge
//
//  Created by 陳姿穎 on 2019/12/17.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    private let router = Router<RedSoApi>()
    
    func getEmployeeData(team: String, page: Int, completion: @escaping (_ response: RedSoModel?, _ error: String?)->()) {
        router.request(.catalog(team: team, page: page)) { (data, response, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                
                guard let responseData = data else {
                    completion(nil, "Response returned with no date to decode.")
                    return
                }
                do {
//                    print(responseData)
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print(jsonData)
                    let apiResponse = try JSONDecoder().decode(RedSoModel.self, from: responseData)
                    completion(apiResponse,nil)
                } catch {
//                    print(error)
                    completion(nil, "Could not decode the response.")
                }
            }
        }
    }
    
}
