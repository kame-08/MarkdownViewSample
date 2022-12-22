import SwiftUI

@available(iOS 13.0, *)
public struct MarkdownViewSample {
    public private(set) var text = "Hello, World!"
}

@available(iOS 13.0, *)
public struct MarkdownView: View {
    @State var text = ""
    public init() {
        
    }
    public var body: some View {
        TextField("Markdown", text: $text)
    }
}
