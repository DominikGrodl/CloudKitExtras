//
//  CKDecodable+extract.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public extension CKDecodable {
    static func extract<T>(_ key: Fields, from record: CKRecord) throws -> T {
        try record.extract(key.rawValue)
    }

    static func extractOptional<T>(_ key: Fields, from record: CKRecord) -> T? {
        record.extractOptional(key.rawValue)
    }
}
