import SwiftUI
import AppKit

@main
struct QuickNoteApp: App {
    @StateObject private var store = NoteStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
        .commands {
            CommandGroup(replacing: .saveItem) {
                Button("Zapisz") {
                    _ = store.save()
                }
                .keyboardShortcut("s", modifiers: [.command])
            }
            CommandGroup(after: .appInfo) {
                Button("Pokaż plik w Finderze") {
                    NSWorkspace.shared.activateFileViewerSelecting([store.fileURL])
                }
            }
        }
    }

    func Commands() {
        AppCommands(store: store)
    }
}

