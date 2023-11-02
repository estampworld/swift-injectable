// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Combine

public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}

/// Provides access to injected dependencies.
public struct InjectedValues {

    /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
    private static var current = InjectedValues()

    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    public static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    /// A static subscript accessor for updating and references dependencies directly.
    public static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
public struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    public var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }

    public init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

@available(iOS 15.0, *)
@available(macOS 12.0, *)
extension View {

    public func dependecy<V>(_ keyPath: WritableKeyPath<InjectedValues, V>, _ value: V) -> some View {
        self.task {
            InjectedValues[keyPath] = value
        }
    }

}

@attached(peer, names: suffixed(InjectionKey))
public macro Injectable<T>(default: T.Type) = #externalMacro(
    module: "InjectableMacros",
    type: "InjectableMacro"
)

@attached(member, names: arbitrary)
public macro InjectableValues<T>(name: T.Type) = #externalMacro(
    module: "InjectableMacros",
    type: "InjectableValuesMacro"
)

@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "InjectableMacros", type: "StringifyMacro")
