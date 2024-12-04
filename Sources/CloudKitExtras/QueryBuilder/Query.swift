//
//  Query.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public struct Query<T: CKCodable> {
    let predicate: NSPredicate?
    let sorts: [NSSortDescriptor]
    let limit: Int
    let debug: Bool

    public init() {
        self.predicate = nil
        self.sorts = []
        self.limit = CKQueryOperation.maximumResults
        self.debug = false
    }

    init(
        predicate: NSPredicate?,
        sorts: [NSSortDescriptor],
        limit: Int,
        debug: Bool
    ) {
        self.predicate = predicate
        self.sorts = sorts
        self.limit = limit
        self.debug = debug
    }
}

internal extension Query {
    func appendPredicate(with additionalPredicate: NSPredicate, type: LogicalType) -> NSPredicate {
        if let predicate {
            return NSCompoundPredicate(
                type: type.nsCompountPredicateLogicalTypeRepresentation,
                subpredicates: [predicate, additionalPredicate]
            )
        } else {
            return additionalPredicate
        }
    }

    func addSorts(_ sorts: [NSSortDescriptor]) -> Self {
        copyWith(sorts: self.sorts + sorts)
    }

    func copyWith(
        predicate: NSPredicate? = nil,
        sorts: [NSSortDescriptor]? = nil,
        limit: Int? = nil,
        debug: Bool? = nil,
        cursor: CKQueryOperation.Cursor? = nil
    ) -> Self {
        Query(
            predicate: predicate ?? self.predicate,
            sorts: sorts ?? self.sorts,
            limit: limit ?? self.limit,
            debug: debug ?? self.debug
        )
    }
}

