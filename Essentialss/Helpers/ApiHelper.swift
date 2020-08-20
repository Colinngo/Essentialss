//
//  ApiHelper.swift
//  DaNang43.vn
//
//  Created by Colin Ngo on 7/17/19.
//  Copyright © 2019 QTS Coder. All rights reserved.
//

import UIKit
import Alamofire

struct ApiHelper {
    static let shared = ApiHelper()
    private let auth_headerLogin: HTTPHeaders    = ["Content-Type": "application/json"]
    private var manager: Alamofire.SessionManager
    
    private init() {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            URL_WS: .disableEvaluation
        ]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    
    func getBannarHomePage(complete:@escaping (_ arrs: [HomeObj]?) ->Void) {
        print("URL -->","\(URL_WS)custome/get-all-banners")
        manager.request(URL.init(string: "\(URL_WS)custome/get-all-banners")!, method: .get, parameters: nil,  encoding: URLEncoding(destination: .methodDependent), headers: auth_headerLogin)
            .responseJSON { response in
                print(response)
                switch(response.result) {
                case .success(_):
                    var arrDatas = [HomeObj]()
                    if let json = response.result.value  as? NSDictionary {
                        if let data = json.object(forKey: "payload") as? [NSDictionary]
                        {
                            for item in data
                            {
                                arrDatas.append(HomeObj.init(item))
                            }
                            complete(arrDatas)
                        }
                        else{
                            complete(nil)
                        }
                    }else {
                        complete(nil)
                    }
                case .failure( _):
                    complete(nil)
                }
        }
    }
    
    func getListAllCategory(complete:@escaping (_ arrs: [categoryObj]?) ->Void) {
        print("URL -->","\(URL_WS)category/get-all-categories")
        manager.request(URL.init(string: "\(URL_WS)category/get-all-categories")!, method: .get, parameters: nil,  encoding: URLEncoding(destination: .methodDependent), headers: auth_headerLogin)
            .responseJSON { response in
                print(response)
                switch(response.result) {
                case .success(_):
                    var arrDatas = [categoryObj]()
                    if let json = response.result.value  as? NSDictionary {
                        if let data = json.object(forKey: "payload") as? [NSDictionary]
                        {
                            for item in data
                            {
                                arrDatas.append(categoryObj.init(item))
                            }
                            complete(arrDatas)
                        }
                        else{
                            complete(nil)
                        }
                    }else {
                        complete(nil)
                    }
                case .failure( _):
                    complete(nil)
                }
        }
    }
    
    func getSubCategory(_ category: NSMutableDictionary , complete:@escaping (_ arrs: [subCategoryObj]?) ->Void) {
         print("URL -->","\(URL_WS)category/get-sub-categories-by-category-id")
        print("PARAM-->", category)
        manager.request(URL.init(string: "\(URL_WS)/category/get-sub-categories-by-category-id")!, method: .post, parameters: category as? Parameters,  encoding: JSONEncoding.default, headers: auth_headerLogin)
            .responseJSON { response in
                print(response)
                switch(response.result) {
                case .success(_):
                    var arrDatas = [subCategoryObj]()
                    if let json = response.result.value  as? NSDictionary {
                        if let data = json.object(forKey: "payload") as? [NSDictionary]
                        {
                            for item in data
                            {
                                arrDatas.append(subCategoryObj.init(item))
                            }
                            complete(arrDatas)
                        }
                        else{
                            complete(nil)
                        }
                    }else {
                        complete(nil)
                    }
                case .failure( _):
                    complete(nil)
                }
        }
    }
    
    
    func getListProductByHomePage(_ tag: Int, complete:@escaping (_ arrs: [productObj]?) ->Void) {
        var url = ""
        switch tag {
        case 0:
            url = "\(URL_WS)product/get-list-new-products"
            break
        case 2:
            url = "\(URL_WS)product/get-list-top-sale-products"
            break
        case 1:
            url = "\(URL_WS)product/get-list-discount-products"
            break
        default:
            url = "\(URL_WS)product/get-list-new-products"
        }
        print("URL-->", url)
        manager.request(URL.init(string: url)!, method: .get, parameters: nil,  encoding: URLEncoding(destination: .methodDependent), headers: auth_headerLogin)
            .responseJSON { response in
                print(response)
                switch(response.result) {
                case .success(_):
                    var arrDatas = [productObj]()
                    if let json = response.result.value  as? NSDictionary {
                        if let data = json.object(forKey: "payload") as? [NSDictionary]
                        {
                            for item in data
                            {
                                arrDatas.append(productObj.init(item))
                            }
                            complete(arrDatas)
                        }
                        else{
                            complete(nil)
                        }
                    }else {
                        complete(nil)
                    }
                case .failure( _):
                    complete(nil)
                }
        }
    }
    
    func getListProductBySubCategory(_ param: NSMutableDictionary , complete:@escaping (_ arrs: [productObj]?) ->Void) {
        print("PARAM-->",param)
        print("PARAM-->","\(URL_WS)product/get-products-by-subcategory-id")
        manager.request(URL.init(string: "\(URL_WS)product/get-products-by-subcategory-id")!, method: .post, parameters: param as? Parameters,  encoding: JSONEncoding.default, headers: auth_headerLogin)
            .responseJSON { response in
                print(response)
                switch(response.result) {
                case .success(_):
                    var arrDatas = [productObj]()
                    if let json = response.result.value  as? NSDictionary {
                        if let data = json.object(forKey: "payload") as? [NSDictionary]
                        {
                            for item in data
                            {
                                arrDatas.append(productObj.init(item))
                            }
                            complete(arrDatas)
                        }
                        else{
                            complete(nil)
                        }
                    }else {
                        complete(nil)
                    }
                case .failure( _):
                    complete(nil)
                }
        }
    }
    
    func savePaymentOrderCash(_ param: NSDictionary , complete:@escaping (_ success: Bool?, _ message: String?, _ orderNo: String?,_ orderID: String?) ->Void) {
    print("URL--->","\(URL_WS)order/create-new-order")
       manager.request(URL.init(string: "\(URL_WS)order/create-new-order")!, method: .post, parameters: param as? Parameters,  encoding: JSONEncoding.default, headers: auth_headerLogin)
           .responseJSON { response in
               print(response)
               switch(response.result) {
               case .success(_):
                let statusCode = response.response?.statusCode
                print("response-->",response)
                if statusCode == 200 {
                    var order = ""
                     var orderID = ""
                    if let json = response.result.value  as? NSDictionary {
                        if let payload = json.object(forKey: "payload") as? NSDictionary
                        {
                            HelperCart.saveOrderItem(OrderObj.init(payload))
                            if let orderCreated = payload.object(forKey: "order") as? NSDictionary
                            {
                                order = orderCreated.object(forKey: "orderNo") as? String ?? ""
                                 orderID = orderCreated.object(forKey: "id") as? String ?? ""
                            }
                        }
                    }
                    complete(true, nil, order,orderID)
                }
                else{
                    if let json = response.result.value  as? NSDictionary {
                        complete(false, json.object(forKey: "error") as? String, nil, nil)
                    }
                    else{
                        complete(false, "Server error", nil, nil)
                    }
                }
                
               case .failure( let error):
                    complete(false, error.localizedDescription, nil, nil)
               }
       }
   }
    
    func seachProduct(_ param: NSMutableDictionary , complete:@escaping (_ arrs: [productObj]?) ->Void) {
        print("PARAM-->",param)
        print("URL--->","\(URL_WS)product/search")
        manager.request(URL.init(string: "\(URL_WS)product/search")!, method: .post, parameters: param as? Parameters,  encoding: JSONEncoding.default, headers: auth_headerLogin)
            .responseJSON { response in
                print(response)
                switch(response.result) {
                case .success(_):
                    var arrDatas = [productObj]()
                    if let json = response.result.value  as? NSDictionary {
                        if let data = json.object(forKey: "payload") as? [NSDictionary]
                        {
                            for item in data
                            {
                                arrDatas.append(productObj.init(item))
                            }
                            complete(arrDatas)
                        }
                        else{
                            complete(nil)
                        }
                    }else {
                        complete(nil)
                    }
                case .failure( _):
                    complete(nil)
                }
        }
    }
    
    func updateOrderPayment(_ param: NSMutableDictionary , complete:@escaping (_ success: Bool, _ err: String?) ->Void) {
        print("PARAM-->",param)
        print("URL--->","\(URL_WS)order/update-order-payment")
        manager.request(URL.init(string: "\(URL_WS)order/update-order-payment")!, method: .post, parameters: param as? Parameters,  encoding: JSONEncoding.default, headers: auth_headerLogin)
            .responseJSON { response in
                print(response)
                switch(response.result) {
                case .success(_):
                    if response.response?.statusCode == 200 {
                        complete(true, nil)
                    }
                    else{
                        complete(false, nil)
                    }
                case .failure( _):
                    complete(false, nil)
                }
        }
    }
}

