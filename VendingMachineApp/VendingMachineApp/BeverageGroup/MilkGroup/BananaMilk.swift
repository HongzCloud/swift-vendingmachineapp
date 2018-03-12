//
//  BananaMilk.swift
//  VendingMachine
//
//  Created by Eunjin Kim on 2018. 1. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class BananaMilk: Milk {
    private var bananaSyrup: Int = 1
    convenience init() {
        self.init(brand: "", weight: 0, price: 0, name: "", manufactureDate: Date(), bananaSyrup: 1)
    }
    init(brand: String, weight: Int, price: Int, name: String, manufactureDate: Date, bananaSyrup: Int) {
        self.bananaSyrup = bananaSyrup
        super.init(brand: brand, weight: weight, price: price, name: name, manufactureDate: manufactureDate)
        super.kindOf = "바나나우유"
    }

    func quantityOfBananaSyrup() -> Int {
        return self.bananaSyrup
    }
    
    func isModerateSyrup() -> Bool {
        return bananaSyrup == 5
    }
}
