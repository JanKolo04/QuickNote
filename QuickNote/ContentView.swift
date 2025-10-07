import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: NoteStore
    @FocusState private var isFocused: Bool

    var body: some View {
        TextEditor(text: $store.text)
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .padding()
            .frame(minWidth: 520, minHeight: 380)
            .onAppear {
                NSApplication.shared.activate(ignoringOtherApps: true)
                isFocused = true
            }
            .focused($isFocused)
            .onChange(of: store.text) { _ in
                store.scheduleSave()
        }
    }
}
