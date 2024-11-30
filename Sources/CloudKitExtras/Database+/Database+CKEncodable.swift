//
//  Database+CKEncodable.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public extension CKDatabase {
    func save<T: CKEncodable>(model: T, recordId: CKRecord.ID? = nil) async throws {
        try await save(model.encode(recordID: recordId))
    }
}
