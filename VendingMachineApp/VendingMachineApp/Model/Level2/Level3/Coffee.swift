//
//  Coffee.swift
//  VendingMachineApp
//
//  Created by 오킹 on 2021/02/24.
//

import Foundation

class Coffee: Beverage, CustomStringConvertible {
    private var isHot: Bool
    
    init(brand: String, miliLiter: Int, price: Int, name: String, dateOfManufacture: Date, isHot: Bool) {
        self.isHot = isHot
        super.init(brand: brand, miliLiter: miliLiter, price: price, name: name, dateOfManufacture: dateOfManufacture)
    }
}
