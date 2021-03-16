//
//  ArchivingManager.swift
//  VendingMachineApp
//
//  Created by 오킹 on 2021/03/15.
//

import Foundation

class ArchivingManager {
//    static func archive(with things: VendingMachine) -> Data {
//
//        guard let archived = try? NSKeyedArchiver.archivedData(withRootObject: things, requiringSecureCoding: false) else {
//            return Data()
//        }
//
//        return archived
//    }
//
//    static func unarchive(with text: Data) -> VendingMachine? {
//
//        guard let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(text) else {
//            return nil
//        }
//
//        return object as? VendingMachine
//    }
    static func archive(with things: VendingMachine) -> Data {
        do {
            let archived = try NSKeyedArchiver.archivedData(withRootObject: things, requiringSecureCoding: false)
            return archived
        }
        catch {
            print(error)
        }
        return Data()
    }

    static func unarchive(with text: Data) -> VendingMachine? {
        do {
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(text)
            return object as? VendingMachine
        }
        catch {
            print(error)
        }
        return nil
    }
}
