import FluentKit
import Foundation
import Hummingbird
import HummingbirdFluent
import NIO

struct TodoController {
    func addRoutes(to group: HBRouterGroup) {
        group
            .get(use: index)
            .post(options: .editResponse, use: create)
            .delete(":id", use: delete)
    }

    func index(_ request: HBRequest) -> EventLoopFuture<[Todo]> {
        return Todo.query(on: request.db)
            .limit(50)
            .all()
    }

    func create(_ request: HBRequest) -> EventLoopFuture<Todo> {
        guard let todo = try? request.decode(as: Todo.self) else { return request.failure(HBHTTPError(.badRequest)) }
        return todo.save(on: request.db).map { todo }
    }

    func get(_ request: HBRequest) -> EventLoopFuture<Todo?> {
        guard let id = request.parameters.get("id", as: UUID.self) else { return request.failure(HBHTTPError(.badRequest)) }
        return Todo.find(id, on: request.db)
    }

    func delete(_ request: HBRequest) -> EventLoopFuture<HTTPResponseStatus> {
        guard let id = request.parameters.get("id", as: UUID.self) else { return request.failure(HBHTTPError(.badRequest)) }
        return Todo.find(id, on: request.db)
            .unwrap(orError: HBHTTPError(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
