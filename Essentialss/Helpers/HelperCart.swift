//
//  HelperCart.swift
//  Essentialss
//
//  Created by QTS Coder on 7/31/20.
//  Copyright © 2020 QTS Coder. All rights reserved.
//

import UIKit

class HelperCart: NSObject {
    
    static func saveProduct(_ productObj: productObj)
    {
       var items: [Data] = []
       for geotification in self.listProductSaved() {
           let item = NSKeyedArchiver.archivedData(withRootObject: geotification)
           items.append(item)
       }
       let item = NSKeyedArchiver.archivedData(withRootObject: productObj)
       items.append(item)
       UserDefaults.standard.set(items, forKey: kCartLocal)
    }
       
       static func listProductSaved()->[productObj]
       {
           var arrSaveds = [productObj]()
            guard let savedItems = UserDefaults.standard.array(forKey: kCartLocal) else { return [] }
           for savedItem in savedItems {
              guard let product = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? productObj else { continue }
              arrSaveds.append(product)
           }
           return arrSaveds
       }
       
       static func checkProductExit(_ productObj: productObj) -> Bool
       {
           guard let savedItems = UserDefaults.standard.array(forKey: kCartLocal) else { return false }
           for savedItem in savedItems {
               guard let geotification = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? productObj else { continue }
                if geotification.id == productObj.id
               {
                   return true
               }
           }
           return false
       }
       
    
    static func saveAllProductCart() {
        var items: [Data] = []
        for geotification in self.listProductSaved() {
            let item = NSKeyedArchiver.archivedData(withRootObject: geotification)
            items.append(item)
        }
        UserDefaults.standard.set(items, forKey: kCartLocal)
    }
    
    static func updateNumberCart(_ productObj: productObj)
    {
        var items: [Data] = []
        guard let savedItems = UserDefaults.standard.array(forKey: kCartLocal) else { return }
        for savedItem in savedItems {
            guard let geotification = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? productObj else { continue }
            if geotification.id == productObj.id
            {
                geotification.number = productObj.number
                let item = NSKeyedArchiver.archivedData(withRootObject: geotification)
                items.append(item)
            }
            else{
                let item = NSKeyedArchiver.archivedData(withRootObject: geotification)
                items.append(item)
            }
        }
        UserDefaults.standard.set(items, forKey: kCartLocal)
    }
    
    static func removeProduct(_ productObj: productObj)
    {
        var items: [Data] = []
        let savedItems = UserDefaults.standard.array(forKey: kCartLocal)
        for savedItem in savedItems! {
            guard let geotification = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? productObj else { continue }
           
            if geotification.id == productObj.id
            {
                
            }
            else{
                let item = NSKeyedArchiver.archivedData(withRootObject: geotification)
                items.append(item)
            }
        }
        UserDefaults.standard.set(items, forKey: kCartLocal)
    }
    
    static func saveOrderItem(_ order: OrderObj)
   {
      var items: [Data] = []
      for geotification in self.listOrderPayment() {
          let item = NSKeyedArchiver.archivedData(withRootObject: geotification)
          items.append(item)
      }
      let item = NSKeyedArchiver.archivedData(withRootObject: order)
      items.append(item)
      UserDefaults.standard.set(items, forKey: kOrderPayment)
   }
      
      static func listOrderPayment()->[OrderObj]
      {
          var arrSaveds = [OrderObj]()
           guard let savedItems = UserDefaults.standard.array(forKey: kOrderPayment) else { return [] }
          for savedItem in savedItems {
             guard let product = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? OrderObj else { continue }
             arrSaveds.append(product)
          }
          return arrSaveds
      }
}
