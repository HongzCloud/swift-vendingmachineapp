//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by 이동영 on 16/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias State = (balance: Money, inventory: Storable, history: History)

protocol VendingMachinePresenterType: MoneyHandleable {
    var numOfRow: Int { get }
    func configure(cell: ProductCellType, index: Int)
    func setStrategy(_ strategy: StateHandleable?)
    func execute() throws
}

class VendingMachinePresenter {
    var isOnSale: Bool {
        return !inventory.filter(by: .all).isEmpty
    }
    private var balance: Money
    private var inventory: Storable
    private var history: History
    private var strategy: StateHandleable?
    
    init(balance: Money,
         inventory: Storable,
         history: History) {
        self.balance = balance
        self.inventory = inventory
        self.history = history
    }
    
    func setStrategy(_ strategy: StateHandleable?) {
        self.strategy = strategy
    }
    
    func execute() throws {
        let state = (balance: balance, inventory: inventory, history: history)
        guard
            let result = strategy?.handle(state)
            else { return }
        try resultHandle(result)
    }
    
    func handleStrategy(_ handler: (StateHandleable) -> Void) {
        guard
            let strategy = strategy
            else { return }
        handler(strategy)
    }
    
    func resultHandle(_ result: Result<State, Error>) throws {
        switch result {
        case .success(let newState):
            (self.balance, self.inventory, self.history) = newState
            self.strategy?.complete()
        case .failure(let error):
            throw error
        }
    }
    
}
// MARK: - + MoneyHandleable
extension VendingMachinePresenter: MoneyHandleable {
    
    func handleMoney(_ handler: (Money) -> Void) {
        handler(balance)
    }
    
}
// MARK: - + MoneyHandleable
extension VendingMachinePresenter: ProductStatisticHandleable {
    
    func handleProductStatistic(_ handler: ([ProductStatistic]) -> Void) {
        handler(inventory.statistic)
    }
}
extension VendingMachinePresenter: VendingMachinePresenterType {
    
    var numOfRow: Int {
        return inventory.statistic.count
    }
    
    func configure(cell: ProductCellType, index: Int) {
        let product = inventory.statistic[index]
        cell.displayProductImage(imageName: product.productName)
        cell.displayProductStock(quantity: product.productQuantity)
    }
    
}
