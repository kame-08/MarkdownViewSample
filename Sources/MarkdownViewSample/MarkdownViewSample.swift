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
        
        TextField("Markdown", text: $text ,axis: .vertical)
            .font(markdownCheck(text))
        
    }
    
    func markdownCheck(_ text: String) -> Font {
        if text.prefix(4) == "### " {
            return Font.title3
        } else if text.prefix(3) == "## " {
            return Font.title2
        } else if text.prefix(2) == "# " {
            return Font.title
        } else if text.prefix(8) == "https://" {
            return Font.body
        } else {
            return Font.body
        }
    }
}
