import SwiftUI

@available(iOS 16.0, *)
public struct MarkdownViewSample {
    public private(set) var text = "Hello, World!"
    public var type: MarkdownViewStyle
    
}

@available(iOS 16.0, *)
public struct MarkdownView: View {
    @State var text = ""
    @State var type: MarkdownViewStyle = .markdoun
    @FocusState private var condition:Bool
    public init() {
        //        condition = true
    }
    
    public var body: some View {
        
        switch type {
        case .vertical:
            VStack {
                Markdown(text: $text)
                textEdit(text: $text)
            }
        case .horizontal:
            HStack {
                textEdit(text: $text)
                Markdown(text: $text)
            }
        case .textEdit:
            textEdit(text: $text)
        case .markdoun:
            Markdown(text: $text)
        }
    }
}

@available(iOS 14.0, *)
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

public enum MarkdownViewStyle {
    case vertical
    case horizontal
    case textEdit
    case markdoun
}

@available(iOS 16.0, *)
struct Markdown: View {
    @Binding var text:String
    var body: some View {
        
        TextField("Markdown", text: $text ,axis: .vertical)
            .font(markdownCheck(text))
    }
}

@available(iOS 16.0, *)
struct textEdit: View {
    @Binding var text:String
    var body: some View {
        TextField("Markdown", text: $text ,axis: .vertical)
    }
}

