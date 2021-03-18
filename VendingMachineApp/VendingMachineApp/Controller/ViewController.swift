//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 오킹 on 2021/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inventoryStackView: UIStackView!
    @IBOutlet weak var moneyLabel: UILabel!
    
    var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private lazy var vendingMachineInfo = VendingMachineInfo(with: delegate.vendingMachine)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInventoryStackView()
        addEventOfBeverageStockButton()
        setUpMoneyLabel()
    }
    
    private func setUpInventoryStackView() {
        vendingMachineInfo.repeatForBeverageView { beverageView in
            inventoryStackView.addArrangedSubview(beverageView)
        }
    }
    
    private func addEventOfBeverageStockButton() {
        vendingMachineInfo.repeatForButton { UIButton in
            UIButton.addTarget(self, action: #selector(addBeverage), for: .touchUpInside)
        }
    }
    
    private func setUpMoneyLabel() {
        moneyLabel.text = "잔액: \(delegate.vendingMachine.showCurrentMoney()) 원"
    }
    
    @objc
    private func addBeverage(_ sender: UIButton!) {
        guard let beverage = vendingMachineInfo.beverageTypeButtons[sender]?.init() else { return }
        
        delegate.vendingMachine.appendInventory(beverage)
        
        vendingMachineInfo.beverageStockLabels[sender]!.text = "\(delegate.vendingMachine.showAllBeverageList()[ObjectIdentifier(type(of: beverage))]?.count ?? 0)"
    }
    
    @IBAction func addMoney5000(_ sender: Any) {
        delegate.vendingMachine.put(in: .fiveThousand)
        setUpMoneyLabel()
    }
    
    @IBAction func addMoney1000(_ sender: Any) {
        delegate.vendingMachine.put(in: .thousand)
        setUpMoneyLabel()
    }
}
