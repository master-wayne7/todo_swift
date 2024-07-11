import SwiftUI

struct AddTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TodoViewModel
    @State private var title = ""
    @State private var description = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 100) // Adjust height to fit about 4 lines
                }
            }
            .navigationTitle("Add Todo")
            .navigationBarItems(trailing: Button("Save") {
                viewModel.addTodoItem(title: title, description: description)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
