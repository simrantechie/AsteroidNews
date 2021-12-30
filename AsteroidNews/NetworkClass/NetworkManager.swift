//
//  NetworkManager.swift
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 22/12/21.
//

import Foundation
import Alamofire
import SwiftyJSON

public struct NetworkManagerReponseStruct {
    
    // Response from server
    public let responseJSON:JSON?
    
    // Error message from server
    public let message:String?
    
    // Status of request
    public let success: Bool?
    
    init(response: JSON?, status: Bool?,error: String?) {
        self.message = error
        self.responseJSON = response
        self.success = status
    }
}

class NetworkManager: NSObject {
    
    class func getRequest(params:[String:Any]?,completion:@escaping (NetworkManagerReponseStruct)->Void) {
        AF.request("https://api.nasa.gov/neo/rest/v1/feed/today?api_key=DEMO_KEY",method: .get,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let data):
               // print(data)
                let json = JSON(data)
                completion(.init(response: json, status: true, error: json["message"].stringValue))
            case .failure(let error):
            print(error)
                completion(.init(response: nil, status: false, error: "Error occured"))
            }
        }
    }
}
