import Hummingbird


extension HBApplication {
    public func configure() throws {
        router.get("/") { _ in
            return "Hello"
        }
    }
}


func run() throws {
    let app = HBApplication(
        configuration: .init(
            address: .hostname("127.0.0.1", port: 8080),
            serverName: "Hummingbird"
        )
    )
    try app.configure()
    try app.start()
    app.wait()
}

try run()
