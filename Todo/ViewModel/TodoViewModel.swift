import Combine
import Foundation

class TodoViewModel: ObservableObject {
    @Published var todoItems: [TodoItem] = [] {
        didSet {
            saveTodoItems()
        }
    }
    @Published var showingAddTodoView = false
    @Published var selectedFilter: Filter = .all

    enum Filter {
        case all, completed, incomplete
    }

    init() {
        loadTodoItems()
    }

    var filteredTodoItems: [TodoItem] {
        switch selectedFilter {
        case .all:
            return todoItems
        case .completed:
            return todoItems.filter { $0.isCompleted }
        case .incomplete:
            return todoItems.filter { !$0.isCompleted }
        }
    }

    func addTodoItem(title: String, description: String) {
        let newTodo = TodoItem(title: title, description: description, isCompleted: false)
        todoItems.append(newTodo)
    }

    func toggleCompletion(for item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }

    func deleteTodoItem(for item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems.remove(at: index)
        }
    }

    func presentAddTodoView() {
        showingAddTodoView = true
    }

    private func saveTodoItems() {
        if let encodedData = try? JSONEncoder().encode(todoItems) {
            UserDefaults.standard.set(encodedData, forKey: "todoItems")
        }
    }

    private func loadTodoItems() {
        if let savedData = UserDefaults.standard.data(forKey: "todoItems"),
           let decodedItems = try? JSONDecoder().decode([TodoItem].self, from: savedData) {
            todoItems = decodedItems
        }
    }
}
