import Foundation
internal import Combine

final class NoteStore: ObservableObject {
    @Published var text: String = ""

    private var saveWorkItem: DispatchWorkItem?
    let fileURL: URL

    init(filename: String = "QuickNote.txt", folder: String = "SzybkaNotatka") {
        // ~/Library/Application Support/SzybkaNotatka/QuickNote.txt
        let supportDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dirURL = supportDir.appendingPathComponent(folder, isDirectory: true)
        try? FileManager.default.createDirectory(at: dirURL, withIntermediateDirectories: true)
        self.fileURL = dirURL.appendingPathComponent(filename)

        if let data = try? Data(contentsOf: fileURL), let str = String(data: data, encoding: .utf8) {
            self.text = str
        } else {
            self.text = "" // pusty start
        }
    }


    func scheduleSave() {
        saveWorkItem?.cancel()
        let work = DispatchWorkItem { [weak self] in
            self?.save()
        }
        saveWorkItem = work

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: work)
    }


    @discardableResult
    func save() -> Bool {
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            return true
        } catch {
            print("Błąd zapisu: \(error)")
            return false
        }
    }
}
