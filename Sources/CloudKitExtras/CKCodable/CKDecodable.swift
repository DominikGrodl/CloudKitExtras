//
//  CKDecodable.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public protocol CKDecodable {
    associatedtype Fields: RecordFields
    init(record: CKRecord) throws
}

extension CKDecodable {
    static func decode(record: CKRecord) throws -> Self {
        try Self.init(record: record)
    }
}
