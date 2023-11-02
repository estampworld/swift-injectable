//
//  StructInjectedKeysFactory.swift
//  
//
//  Created by Eduardo Irias on 11/2/23.
//

import SwiftSyntax
import SwiftSyntaxBuilder

struct StructInjectedKeysFactory {
    func structDeclaration(name: TokenSyntax, type: TypeSyntax, defaultImplentaionName: TokenSyntax) -> StructDeclSyntax {
        StructDeclSyntax(
            name: name,
            inheritanceClause: InheritanceClauseSyntax {
                InheritedTypeSyntax(
                    type: IdentifierTypeSyntax(name: "InjectionKey")
                )
            },
            memberBlockBuilder: {

                VariableDeclSyntax.init(
                    modifiers: [.init(name: TokenSyntax(stringLiteral: "static")) ],
                    Keyword.var,
                    name: .init(stringLiteral: "currentValue"),
                    type: TypeAnnotationSyntax(
                        type: SomeOrAnyTypeSyntax(
                            someOrAnySpecifier: TokenSyntax(stringLiteral: "any"),
                            constraint: type
                        )
                    ),
                    initializer: InitializerClauseSyntax(
                        value: ExprSyntax(stringLiteral: "\(defaultImplentaionName.text)()")
                    )
                )

            }
        )
    }
}
