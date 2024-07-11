import SwiftUI

struct TodoDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TodoViewModel
    var todoItem: TodoItem

    var body: some View {
        VStack {
            Text(todoItem.title)
                .font(.largeTitle)
                .padding()

            Text(todoItem.description)
                .padding()

            HStack {
                Button(action: {
                    viewModel.toggleCompletion(for: todoItem)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(todoItem.isCompleted ? "Mark as Incomplete" : "Mark as Completed")
                        .foregroundColor(.white)
                        .padding()
                        .background(todoItem.isCompleted ? Color.red : Color.green)
                        .cornerRadius(8)
                }
                .padding()

                Button(action: {
                    viewModel.deleteTodoItem(for: todoItem)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding()
            }

            Spacer()
        }
        .navigationTitle("Todo Detail")
    }
}
