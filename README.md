# SwiftInjectable

A Swift library for easy dependecy injection.

Using Swift Macros, SwiftInjectable allows you to easily make inject. Add the @Injectable(default: DefaultDependency.self) to create an Injection key.

## Installation

```
dependencies: [
    .package(url: "https://github.com/estampworld/swift-injectable.git", from: "1.0.0")
]
```

## Usage

### Injecting values

```
@Injectable(default: PokemonServiceAPI.self)
protocol PokeService {
    func fetchPoke() async throws -> [String]
}

struct PokemonServiceAPI: PokeService {
    func fetchPoke() async throws -> [String] {
        []
    }
}
```

```
// Line use for limitation of using Extensions in Macros
@InjectableValues(name: PokeService.self)
extension InjectedValues { }
```

### Setup
