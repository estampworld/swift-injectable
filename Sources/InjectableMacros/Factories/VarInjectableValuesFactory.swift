//
//  VarInjectableValuesFactory.swift
//  
//
//  Created by Eduardo Irias on 11/2/23.
//

import SwiftSyntax
import SwiftSyntaxBuilder

struct VarInjectableValuesFactory {
    func varDeclaration(protocolName: String) -> VariableDeclSyntax {
        VariableDeclSyntax(
            Keyword.var,
            name: .init(stringLiteral: protocolName.capitalizedSentence),
            type: TypeAnnotationSyntax(
                type: SomeOrAnyTypeSyntax(
                    someOrAnySpecifier: TokenSyntax(stringLiteral: "any"),
                    constraint: TypeSyntax(stringLiteral: protocolName)
                )
            ),
            initializer: InitializerClauseSyntax(
                equal: .equalToken(presence: .missing),
                value: ExprSyntax(
                    stringLiteral:
"""
{
get { return Self[\(protocolName)InjectionKey.self] }
set { Self[\(protocolName)InjectionKey.self] = newValue }
}
"""
                )
            )
        )
    }
}
