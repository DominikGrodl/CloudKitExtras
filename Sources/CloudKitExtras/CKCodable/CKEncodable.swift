//
//  CKEncodable.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public protocol CKEncodable {
    associatedtype Fields: RecordFields
    static var RecordType: String { get }
    func value(for field: Fields) -> CKRecordValueProtocol?
}

extension CKEncodable {
    func setData(to record: CKRecord) {
        Fields.allCases.forEach { field in
            record[field.rawValue] = value(for: field)
        }
    }

    func encode(recordID: CKRecord.ID?) async throws -> CKRecord {
        let record = CKRecord(
            recordType: Self.RecordType,
            recordID: recordID ??  CKRecord.ID()
        )

        setData(to: record)
        return record
    }
}
