import FluentPostgresDriver
import Hummingbird
import HummingbirdFoundation
import HummingbirdFluent
import Foundation


extension HBApplication {
    public func configure() throws {
        encoder = JSONEncoder()
        decoder = JSONDecoder()

        middleware.add(HBLogRequestsMiddleware(.debug))
        middleware.add(HBCORSMiddleware(
            allowOrigin: .originBased,
            allowHeaders: ["Content-Type"],
            allowMethods: [.GET, .OPTIONS, .POST, .DELETE, .PATCH]
        ))

        addFluent()

        fluent.databases.use(.postgres(
            hostname: "localhost",
            port: 7432,
            username: "spi_dev",
            password: "xxx",
            database: "spi_dev"
        ), as: .psql)

        fluent.migrations.add(CreateTodo())
        try fluent.migrate().wait()

        router.get("/") { _ in
            return "Hello"
        }

        let todoContoller = TodoController()
        todoContoller.addRoutes(to: router.group("todos"))
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
