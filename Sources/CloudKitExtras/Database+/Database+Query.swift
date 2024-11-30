//
//  Database+Query.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public extension CKDatabase {
    func perform<T: CKDecodable>(
        _ query: Query<T>
    ) async throws -> CKResult<T> {
        let result = try await self.records(
            matching: query.build(),
            desiredKeys: T.Fields.fields,
            resultsLimit: query.limit
        )

        let mapped: [CKRecordResult] = result.matchResults
            .map { id, result in
                do {
                    switch result {
                    case let .success(record):
                        return (id, .success(try T.decode(record: record)))

                    case let .failure(error):
                        throw error
                    }
                } catch {
                    return (id, .failure(error))
                }
            }

        if query.debug {
            dump(mapped)
        }

        return (mapped, result.queryCursor)
    }
}
