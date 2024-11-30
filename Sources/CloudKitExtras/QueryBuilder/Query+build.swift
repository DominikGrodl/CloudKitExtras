//
//  Query+build.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

extension Query {
    func build() -> CKQuery {
        let query = CKQuery(
            recordType: T.RecordType,
            predicate: self.predicate ?? NSPredicate(value: true)
        )

        query.sortDescriptors = sorts

        if debug {
            let predicate = self.predicate.debugDescription
            let sorts = self.sorts.debugDescription
            debugPrint("Query of \(T.self) with predicate: \(predicate), sorts: \(sorts), limit: \(limit)")
        }
        return query
    }
}
