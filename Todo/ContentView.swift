import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var newTodoTitle = ""
    @State private var newTodoDescription = ""

    var body: some View {
        NavigationView {
            VStack {
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    Text("All").tag(TodoViewModel.Filter.all)
                    Text("Completed").tag(TodoViewModel.Filter.completed)
                    Text("Incomplete").tag(TodoViewModel.Filter.incomplete)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    ForEach(viewModel.filteredTodoItems) { item in
                        NavigationLink(destination: TodoDetailView(viewModel: viewModel, todoItem: item)) {
                            HStack {
                                Text(item.title)
                                    .strikethrough(item.isCompleted)
                                Spacer()
                                if item.isCompleted {
                                                                Button(action: {
                                                                    viewModel.deleteTodoItem(for: item)
                                                                }) {
                                                                    Image(systemName: "trash")
                                                                }
                                                                .buttonStyle(BorderlessButtonStyle()) // Ensure button works within the list
                                                            } else {
                                                                Button(action: {
                                                                    viewModel.toggleCompletion(for: item)
                                                                }) {
                                                                    Image(systemName: "checkmark")
                                                                }
                                                                .buttonStyle(BorderlessButtonStyle()) // Ensure button works within the list
                                                            }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.presentAddTodoView()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showingAddTodoView) {
            AddTodoView(viewModel: viewModel)
        }
    }
}
