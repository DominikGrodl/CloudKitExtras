//
//  Query+options.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit
import CoreLocation

public extension Query {
    func limit(to count: Int) -> Self {
        copyWith(limit: count)
    }

    func filter(
        predicate: NSPredicate,
        type: LogicalType = .and
    ) -> Self {
        copyWith(predicate: appendPredicate(with: predicate, type: type))
    }

    func debug(_ flag: Bool = true) -> Self {
        copyWith(debug: flag)
    }

    func filter(
        _ field: T.Fields,
        equals arg: CVarArg,
        type: LogicalType = .and
    ) -> Self {
        self.filter(predicate: T.predicate(field, equals: arg), type: type)
    }

    func filter(
        _ field: T.Fields,
        anyIn arg: CVarArg,
        type: LogicalType = .and
    ) -> Self {
        self.filter(predicate: T.predicate(field, anyIn: arg), type: type)
    }

    func sorted(by keys: [T.Fields], ascending: Bool) -> Self {
        let sorts = keys.map { field in
            T.sort(by: field, ascending: ascending)
        }

        return addSorts(sorts)
    }

    func sorted(by key: T.Fields, ascending: Bool) -> Self {
        let sort = T.sort(by: key, ascending: ascending)
        return addSorts([sort])
    }
}
