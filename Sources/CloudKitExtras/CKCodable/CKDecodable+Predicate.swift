//
//  CKDecodable+Predicate.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import Foundation
import CoreLocation

public extension CKDecodable {
    static func predicate(_ key: Fields, equals arg: CVarArg) -> NSPredicate {
        NSPredicate(format: "\(key.rawValue) == %@", arg)
    }

    static func predicate(_ key: Fields, anyIn arg: CVarArg) -> NSPredicate {
        NSPredicate(format: "ANY \(key.rawValue) IN %@", arg)
    }

    static func predicate(_ key: Fields, in arg: CVarArg) -> NSPredicate {
        NSPredicate(format: "\(key.rawValue) IN %@", arg)
    }

    static func sort(by key: Fields, ascending: Bool) -> NSSortDescriptor {
        NSSortDescriptor(key: key.rawValue, ascending: ascending)
    }
}
