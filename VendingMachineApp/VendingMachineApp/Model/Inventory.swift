//
//  Inventory.swift
//  VendingMachineApp
//
//  Created by 오킹 on 2021/03/01.
//

import Foundation

class Inventory: NSObject, NSCoding {

    private var beverages: Beverages
    
    override init() {
        self.beverages = Beverages()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(beverages, forKey: "InventoryBeverages")
    }
    
    required init?(coder: NSCoder) {
        beverages = coder.decodeObject(forKey: "InventoryBeverages") as! Beverages
    }
    
    public func append(_ beverage: Beverage) {
        beverages.append(beverage)
    }
    
    public func buyableBeverageList(buyer paymentManager: PaymentManager) -> [Beverage] {
        return beverages.buyableBeverageList(buyer: paymentManager)
    }

    public func take(out beverageType: Beverage.Type, for paymentManager: PaymentManager) -> Beverage? {
        return beverages.take(out: beverageType, for: paymentManager)
    }
    
    public func showAllBeverageList() -> [ObjectIdentifier : [Beverage]] {

        return beverages.showAllBeverageList()
    }
    
    public func showExpiryDateBeverage(over standard: Date) -> [SafeDateChecker] {
        
        return beverages.showExpiryDateBeverage(over: standard)
    }
    
    public func showHotBeverage(over standard: Int) -> [Hotable] {

        return beverages.showHotBeverage(over: standard)
    }
}

