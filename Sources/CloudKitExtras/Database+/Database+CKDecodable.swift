//
//  Database+CKDecodable.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 30.11.2024.
//

import CloudKit

public extension CKDatabase {
    func get<T: CKDecodable>(id: CKRecord.ID, as: T.Type) async throws -> T {
        try await get(id: id)
    }

    func get<T: CKDecodable>(id: CKRecord.ID) async throws -> T {
        try T.init(record: await self.record(for: id))
    }
}
