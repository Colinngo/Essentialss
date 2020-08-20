//
//  DataObj.swift
//  Essentialss
//
//  Created by Colin Ngo on 7/22/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class CartObj
{
    var name = ""
    var price = 1.0
    var number = 1
}


class categoryObj: NSObject {
    var alias = ""
    var createdAt = ""
    var createdBy = ""
    var desc = ""
    var displayOrder = ""
    var id = ""
    var image = ""
    var isActive = true
    var isDeleted = false
    var name = ""
    var updatedAt = ""
    var updatedBy = ""
    var dictInfo = NSDictionary.init()
    init(_ dict: NSDictionary) {
        self.dictInfo = dict
        self.alias = dict["alias"] as? String ?? ""
        self.createdAt = dict["createdAt"] as? String ?? ""
        self.createdBy = dict["createdBy"] as? String ?? ""
        self.desc = dict["description"] as? String ?? ""
        self.displayOrder = dict["displayOrder"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
        self.isActive = dict["isActive"] as? Bool ?? true
        self.isDeleted = dict["isDeleted"] as? Bool ?? true
        self.updatedAt = dict["updatedAt"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.updatedBy = dict["updatedBy"] as? String ?? ""
    }
}
class subCategoryObj: NSObject {
    var alias = ""
    var createdAt = ""
    var createdBy = ""
    var desc = ""
    var displayOrder = ""
    var id = ""
    var image = ""
    var isActive = true
    var isDeleted = false
    var name = ""
    var updatedAt = ""
    var updatedBy = ""
    var categoryId = ""
    var dictInfo = NSDictionary.init()
    init(_ dict: NSDictionary) {
        self.dictInfo = dict
        self.categoryId = dict["categoryId"] as? String ?? ""
        self.alias = dict["alias"] as? String ?? ""
        self.createdAt = dict["createdAt"] as? String ?? ""
        self.createdBy = dict["createdBy"] as? String ?? ""
        self.desc = dict["description"] as? String ?? ""
        self.displayOrder = dict["displayOrder"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
        self.isActive = dict["isActive"] as? Bool ?? true
        self.isDeleted = dict["isDeleted"] as? Bool ?? true
        self.updatedAt = dict["updatedAt"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.updatedBy = dict["updatedBy"] as? String ?? ""
    }
}

class productObj: NSObject, NSCoding
{
    
    
    var alias = ""
    var categoryName = ""
    var catergoryId = ""
    var desc = ""
    var discount = "0.0"
    var id = ""
    var image = [String]()
    var isActive = true
    var name = ""
    var originalPrice = 0.0
    var price = 0.0
    var subCategoryId = ""
    var subCategoryName = ""
    var warranty = ""
    var tags = [String]()
    var number = "1"
    var priceNumber = "0"
    var dictInfo =  NSDictionary.init()
    init(_ dict: NSDictionary) {
        self.alias = dict["alias"] as? String ?? ""
        self.categoryName = dict["categoryName"] as? String ?? ""
        self.catergoryId = dict["catergoryId"] as? String ?? ""
        self.desc = dict["description"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.image = dict["image"] as? [String] ?? [String]()
        self.name = dict["name"] as? String ?? ""
        self.subCategoryId = dict["subCategoryId"] as? String ?? ""
        self.subCategoryName = dict["subCategoryName"] as? String ?? ""
        self.warranty = dict["warranty"] as? String ?? ""
        self.tags = dict["tags"] as? [String] ?? [String]()
        self.discount = dict["discount"] as? String ?? "0.0"
        if self.discount.isEmpty {
            self.discount = "0.0"
        }
        self.originalPrice = dict["originalPrice"] as? Double ?? 0.0
        self.price = dict["price"] as? Double ?? 0.0
         self.priceNumber = "\(dict["price"] as? Double ?? 0.0)"
        print("self.priceNumber-->",self.priceNumber)
        self.dictInfo = dict
    }
    
    // MARK: NSCoding
    
    
    required init?(coder decoder: NSCoder) {
          self.alias = decoder.decodeObject(forKey: "alias") as? String ?? ""
          self.categoryName = decoder.decodeObject(forKey: "categoryName") as? String ?? ""
          self.catergoryId = decoder.decodeObject(forKey: "catergoryId") as? String ?? ""
          self.desc = decoder.decodeObject(forKey: "desc") as? String ?? ""
          self.id = decoder.decodeObject(forKey: "id") as? String ?? ""
          self.image = decoder.decodeObject(forKey: "image") as? [String] ?? [String]()
          self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
          self.subCategoryId = decoder.decodeObject(forKey: "subCategoryId") as? String ?? ""
          self.warranty = decoder.decodeObject(forKey: "warranty") as? String ?? ""
          self.tags = decoder.decodeObject(forKey: "tags") as? [String] ?? [String]()
          self.discount = decoder.decodeObject(forKey: "discount") as? String ?? ""
          self.originalPrice = decoder.decodeObject(forKey: "originalPrice") as? Double ?? 0.0
          self.price = decoder.decodeObject(forKey: "price") as? Double ?? 0.0
          self.dictInfo = decoder.decodeObject(forKey: "dictInfo") as? NSDictionary ?? NSDictionary.init()
          self.number = decoder.decodeObject(forKey: "number") as? String ?? "1"
          self.subCategoryName = decoder.decodeObject(forKey: "subCategoryName") as? String ?? ""
          self.priceNumber = decoder.decodeObject(forKey: "priceNumber") as? String ?? ""
      }
      
      func encode(with coder: NSCoder) {
          coder.encode(self.alias, forKey: "alias")
          coder.encode(self.categoryName, forKey: "categoryName")
          coder.encode(self.catergoryId, forKey: "catergoryId")
          coder.encode(self.desc, forKey: "desc")
          coder.encode(self.id, forKey: "id")
          coder.encode(self.image, forKey: "image")
          coder.encode(self.name, forKey: "name")
          coder.encode(self.subCategoryId, forKey: "subCategoryId")
          coder.encode(self.warranty, forKey: "warranty")
          coder.encode(self.tags, forKey: "tags")
          coder.encode(self.discount, forKey: "discount")
          coder.encode(self.originalPrice, forKey: "originalPrice")
          coder.encode(self.price, forKey: "price")
          coder.encode(self.dictInfo, forKey: "dictInfo")
          coder.encode(self.number, forKey: "number")
          coder.encode(self.subCategoryName, forKey: "subCategoryName")
          coder.encode(self.priceNumber, forKey: "priceNumber")
      }
}

class PaymentObj: NSObject {
    var name = ""
    var phoneNumer = ""
    var address = ""
    var note = ""
    
    var email = ""
    var city = ""
    var state = ""
    
    var nameShipping = ""
    var phoneNumerShipping = ""
    var addressShipping = ""
    
    var emailShipping = ""
    var cityShipping = ""
    var stateShipping = ""
    
    var nameDelivery = ""
    var phoneNumerDelivery = ""
    var addressDelivery = ""
    var noteDelivery = ""
    
    var cardNumber = ""
    var cardName = ""
    var cardExpiry = ""
    var CCV = ""
    var isDelivery = false
}

class OrderObj: NSObject, NSCoding
{
    var orderCreated = NSDictionary.init()
    var orderItemsCreated = [NSDictionary]()
    init(_ dict: NSDictionary) {
        self.orderCreated = dict["order"] as? NSDictionary ?? NSDictionary.init()
        self.orderItemsCreated = dict["orderDetai"] as? [NSDictionary] ?? [NSDictionary]()
    }
    required init?(coder decoder: NSCoder) {
        self.orderCreated = decoder.decodeObject(forKey: "orderCreated") as? NSDictionary ?? NSDictionary.init()
        self.orderItemsCreated = decoder.decodeObject(forKey: "orderItemsCreated") as? [NSDictionary] ?? [NSDictionary]()
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.orderCreated, forKey: "orderCreated")
        coder.encode(self.orderItemsCreated, forKey: "orderItemsCreated")
    }
}

class HomeObj
{
    var name = ""
    var image = ""
    init(_ dict: NSDictionary) {
        self.name = dict["name"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
    }
}
