//
//  Plugins.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 24.11.2024.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct MacrosPlugin: CompilerPlugin {
    let providingMacros: [any Macro.Type] = [
        CKCodableMacro.self,
        CKDecodableMacro.self,
        CKEncodableMacro.self
    ]
}
