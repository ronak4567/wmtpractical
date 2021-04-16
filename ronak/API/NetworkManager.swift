//
//  APICall.swift
//  ronak
//
//  Created by Depixed on 16/04/21.
//

import Foundation
import Alamofire



class NetworkManager{
    let baseURL: String
    
    static let shared = NetworkManager(baseURL: "http://68.183.48.101:3333/users/")
    
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func registerUserAPI(param: Dictionary<String,String>,completionHandler: @escaping (User) -> Void) {
        
        let urlRegister = baseURL + "register"
        let request = AF.request(urlRegister, method: .post, parameters: param)
        print(param)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any] {
                    let user = User(dict: JSON)
                    print(user);
                    completionHandler(user)
                }
            case .failure( _): break
            // error handling
            }
            
            
        }
    }
    
    func getUserList(page: Int, strToken: String,completionHandler: @escaping (Dictionary<String,Any>) -> Void) {
        
        let urlRegister = baseURL + "list?page=\(page)"
        let request = AF.request(urlRegister, method: .get, headers: ["Authorization": "Bearer \(strToken)"])
        request.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any] {
//                    print(JSON);
                    completionHandler(JSON)
                    
                }
            case .failure( _): break
            // error handling
            }
            
            
        }
    }
}


//if response.result.isSuccess {
//                if let dictResult:[String:Any] = response.result.value as! [String : Any]? {
//                    print("apiContactSearch:\(dictResult)")
//                    if dictResult["error"] as! Int == 1 {
//                        if dictResult["message"] as! String == "Expired token" {
//                            appDelegate.loginAPICall(openPage: "callsearchcontactapi")
//                        }
//                    }else {
//                        self.arrSearchList = dictResult["data"] as! [Any]
//                        self.tblList.reloadData()
//                    }
//                }
//            }else{
//                if let error = response.result.error {
//                    showAlert(msg: "Something Went Wrong. Try Again.")
//                }
//            }
