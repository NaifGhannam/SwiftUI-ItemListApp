import SwiftUI

struct ItemModel: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct ContentView: View {
    @State private var items: [ItemModel] = [
        ItemModel(name: "Book", imageName: "book"),
        ItemModel(name: "Clock", imageName: "clock"),
        ItemModel(name: "Phone", imageName: "phone"),
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(systemName: item.imageName)
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(item.name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    // Function to add a new item
    func addItem() {
        withAnimation {
            let newItem = ItemModel(name: "New Item \(items.count + 1)", imageName: "plus")
            items.insert(newItem, at: 0)
        }
    }
    
    // Function to delete an item
    func deleteItems(at offsets: IndexSet) {
        withAnimation {
            items.remove(atOffsets: offsets)
        }
    }
}

// Detail screen to show item information
struct DetailView: View {
    let item: ItemModel
    
    var body: some View {
        VStack {
            Image(systemName: item.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
        }
        .navigationTitle("Item Details")
    }
}
