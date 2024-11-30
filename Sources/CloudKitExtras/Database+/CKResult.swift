//
//  File.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import CloudKit

public typealias CKRecordResult<T: CKDecodable> = (id: CKRecord.ID, result: Result<T, Error>)
public typealias CKResult<T: CKDecodable> = (models: [CKRecordResult<T>], cursor: CKQueryOperation.Cursor?)
