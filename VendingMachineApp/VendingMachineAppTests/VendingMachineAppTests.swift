//
//  VendingMachineAppTests.swift
//  VendingMachineAppTests
//
//  Created by 오킹 on 2021/03/03.
//

import XCTest

class VendingMachineAppTests: XCTestCase {
    
    var vendingMachine = VendingMachine()
    var beverage = MilkFactory.create()
    var beverage2 = SodaFactory.create()
    var beverage3 = CoffeeFactory.create()
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    
    }

    func test_잔액_확인() throws {
        XCTAssertEqual(vendingMachine.showCurrentMoney(), 0)
    }
    
    func test_자판기_금액_추가() throws {
        vendingMachine.put(in: .fiveThousand)
        
        XCTAssertEqual(vendingMachine.showCurrentMoney(), 5000)
    }
    
    func test_음료_재고_추가() throws {
        vendingMachine.appendInventory(beverage)
        vendingMachine.appendInventory(beverage2)
        vendingMachine.appendInventory(beverage3)
    }
    
    func test_구매_가능_음료목록() throws {
        vendingMachine.put(in: .fiveThousand)
        
        vendingMachine.appendInventory(beverage)
        vendingMachine.appendInventory(beverage2)
        vendingMachine.appendInventory(beverage3)
        
        XCTAssertEqual(vendingMachine.beverageListForPurchase(), [beverage,beverage2,beverage3])
    }
    
    func test_음료_구매() throws {
        vendingMachine.put(in: .fiveThousand)
        
        vendingMachine.appendInventory(beverage)
        vendingMachine.appendInventory(beverage2)
        vendingMachine.appendInventory(beverage3)
        
        vendingMachine.buy(type(of: beverage.self))
    }
    
    func test_전체상품_재고_확인() throws {
        vendingMachine.appendInventory(beverage)
        vendingMachine.appendInventory(beverage2)
        vendingMachine.appendInventory(beverage3)
        
        XCTAssertEqual(vendingMachine.showAllBeverageList(), [ObjectIdentifier(type(of: beverage.self)):[beverage], ObjectIdentifier(type(of: beverage2.self)):[beverage2], ObjectIdentifier(type(of: beverage3.self)):[beverage3]])
    }

    func test_유통기한_넘은_재고목록() throws {
        let fakeBananaMilk = BananaMilk(brand: "테스트", capacity: 200, price: 1000, name: "바나나우유_테스트", manufacture: Date(), farmCode: "A_테스트", hasDoraemonSticker: true, expiredAt: Calendar.current.date(byAdding: .day, value: -5, to: Date())!)
    
            vendingMachine.appendInventory(fakeBananaMilk)
    
        XCTAssertEqual(vendingMachine.showExpiryDateBeverage(over: Calendar.current.date(byAdding: .day, value: -5, to: Date())!).map{$0 as! Beverage}, [fakeBananaMilk])
    }
    
    func test_따뜻한_음료_목록() throws {
        let fakeTop = Top(brand: "테스트", capacity: 300, price: 1000, name: "테스트", manufacture: Date(), temperature: 70, hasSugar: true, expiredAt: Date())
    
            vendingMachine.appendInventory(fakeTop)
    
        XCTAssertEqual(vendingMachine.showHotBeverage(over: 60).map{$0 as! Beverage}, [fakeTop])
    }
    
    func test_상품_구매_이력() throws {
        vendingMachine.appendInventory(beverage)
        vendingMachine.appendInventory(beverage2)
        vendingMachine.appendInventory(beverage3)
        vendingMachine.buy(type(of: beverage.self))
        vendingMachine.buy(type(of: beverage2.self))
        
        XCTAssertEqual(vendingMachine.showPurchaseHistory(), [])
    }
    
    func test_통합_테스트_시나리오() throws {
        //음료 재고 넣기
        vendingMachine.appendInventory(beverage)
        vendingMachine.appendInventory(beverage2)
        vendingMachine.appendInventory(beverage3)
        
        //금액 투입
        vendingMachine.put(in: .fiveThousand)
        XCTAssertEqual(vendingMachine.showCurrentMoney(), 5000)
        
        //구매 가능한 상품 확인
        XCTAssertEqual(vendingMachine.beverageListForPurchase(), [beverage,beverage2,beverage3])
        
        //구매
        vendingMachine.buy(type(of: beverage.self))
        
        //잔액 확인
        XCTAssertEqual(vendingMachine.showCurrentMoney(), 3000)
        
        //재고 상태 확인
        XCTAssertEqual(vendingMachine.showAllBeverageList(), [  ObjectIdentifier(type(of: beverage2.self)):[beverage2], ObjectIdentifier(type(of: beverage3.self)):[beverage3]])
        
        //구매 상품 이력 확인
        XCTAssertEqual(vendingMachine.showPurchaseHistory(), [beverage])
    }
}
