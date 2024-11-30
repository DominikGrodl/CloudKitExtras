//
//  Macros.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

@attached(member, names: named(Fields), named(init))
@attached(extension, conformances: CKDecodable)
public macro CKDecodable() = #externalMacro(module: "CloudKitExtrasMacros", type: "CKDecodableMacro")

@attached(extension, conformances: CKEncodable)
@attached(member, names: named(Fields), named(value(for:)))
public macro CKEncodable() = #externalMacro(module: "CloudKitExtrasMacros", type: "CKEncodableMacro")

@attached(member, names: named(Fields), named(init), named(value(for:)))
@attached(extension, conformances: CKDecodable, CKEncodable)
public macro CKCodable() = #externalMacro(module: "CloudKitExtrasMacros", type: "CKCodableMacro")
