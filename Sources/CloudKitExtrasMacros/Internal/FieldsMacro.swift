//
//  FieldsMacro.swift
//  CloudKitExtras
//
//  Created by Dominik Grodl on 25.11.2024.
//

import SwiftDiagnostics
import SwiftOperators
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros

enum FieldsMacro {}

extension FieldsMacro: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw MacroExpansionErrorMessage("@FieldsMacro can only be applied to structs")
        }

        return [
            DeclSyntax.fields(variables: structDecl.instanceVariableNames)
        ]
    }
}
