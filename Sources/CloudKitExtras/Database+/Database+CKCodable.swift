//
//  Database+CKDecodable.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public extension CKDatabase {
    func save<T: CKCodable>(model: T, recordId: CKRecord.ID? = nil) async throws {
        try await save(model.encode(recordID: recordId))
    }

    func get<T: CKCodable>(id: CKRecord.ID, as: T.Type) async throws -> T {
        try await get(id: id)
    }

    func get<T: CKCodable>(id: CKRecord.ID) async throws -> T {
        try T.init(record: await self.record(for: id))
    }
}
