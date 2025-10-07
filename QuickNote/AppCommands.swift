import SwiftUI

struct AppCommands: Commands {
    let store: NoteStore

    var body: some Commands {
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
