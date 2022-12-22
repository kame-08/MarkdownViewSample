import SwiftUI

@available(iOS 16.0, *)
public struct MarkdownViewSample {
    public private(set) var text = "Hello, World!"
}

@available(iOS 16.0, *)
public struct MarkdownView: View {
    @State var text = ""
    @FocusState private var condition:Bool
    public init() {
        condition = true
    }
    
    public var body: some View {
        if text.prefix(4) == "### "{
            TextField("Markdown", text: $text ,axis: .vertical)
                .font(.title3)
                .focused($condition)
        } else if text.prefix(3) == "## "{
            TextField("Markdown", text: $text ,axis: .vertical)
                .font(.title2)
                .focused($condition)
        } else if text.prefix(2) == "# "{
            TextField("Markdown", text: $text ,axis: .vertical)
                .font(.title)
                .focused($condition)
        } else if text.prefix(8) == "https://" {
            TextField("Markdown", text: $text ,axis: .vertical)
                .foregroundColor(Color(.link))
                .underline()
                .focused($condition)
        } else {
            TextField("Markdown", text: $text ,axis: .vertical)
                .focused($condition)
        }
    }
}
