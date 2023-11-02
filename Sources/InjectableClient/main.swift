import Injectable

@Injectable(default: PokemonServiceAPI.self)
protocol PokeService {
    func fetchPoke() async throws -> [String]
}

// Line use for limitation of using Extensions in Macros
@InjectableValues(name: PokeService.self)
extension InjectedValues { }

struct PokemonServiceAPI: PokeService {
    func fetchPoke() async throws -> [String] {
        []
    }
}
