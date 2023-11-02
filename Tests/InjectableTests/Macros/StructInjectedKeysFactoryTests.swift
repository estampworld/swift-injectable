import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
@testable import InjectableMacros

final class StructInjectedKeysFactoryTests: XCTestCase {

    private let sut = StructInjectedKeysFactory()

    func testMacroWithStringLiteral() throws {
        let name = TokenSyntax(stringLiteral: "TestServiceInjectedKeys")
        let type = TypeSyntax(stringLiteral: "TestService")
        let defaultImplemenation = TokenSyntax(stringLiteral: "TestServiceImpl")

        let result = StructInjectedKeysFactory().structDeclaration(name: name, type: type, defaultImplentaionName: defaultImplemenation)
        assertBuildResult(
            result,
            """
            struct TestServiceInjectedKeys: InjectionKey {
                static var currentValue: any TestService = TestServiceImpl()
            }
            """
        )
    }

}
