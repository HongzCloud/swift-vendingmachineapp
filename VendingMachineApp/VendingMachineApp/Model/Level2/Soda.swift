//
//  Soda.swift
//  VendingMachineApp
//
//  Created by 오킹 on 2021/02/24.
//

import Foundation

class Soda: Beverage, CustomStringConvertible {
    
    private var taste: String
    
    init(brand: String, capacity: Int, price: Int, name: String, manufacture: Date, taste: String, expiredAt: Date) {
        self.taste = taste
        super.init(brand: brand, capacity: capacity, price: price, name: name, manufacture: manufacture, expiredAt: expiredAt)
    }
    
    required init() {
        self.taste = "레몬맛"
        super.init(brand: "unkowun", capacity: 200, price: 1000, name: "소다",manufacture: Date(), expiredAt: Calendar.current.date(byAdding: .day, value: 180, to: Date())!)
    }
}
