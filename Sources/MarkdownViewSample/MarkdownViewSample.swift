import SwiftUI

@available(iOS 16.0, *)
public struct MarkdownViewSample {
    public private(set) var text = "Hello, World!"
    public private(set) var markdownViewStyle: MarkdownViewStyle
}

@available(iOS 16.0, *)
public struct MarkdownView: View {
    @State var text: String
    @State public var markdownViewStyle: MarkdownViewStyle
    @FocusState private var condition:Bool
    public init(text: String ,markdownViewStyle: MarkdownViewStyle) {
        self.text =  text
        self.markdownViewStyle = markdownViewStyle
    }
    
    public var body: some View {
        
        switch markdownViewStyle {
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
    @State var textArr:[String] = [""]
    var body: some View {
        ForEach(0 ..< textArr.count) { num in
            TextField("Markdown", text: $textArr[num] ,axis: .vertical)
                .font(markdownCheck(text))
        }
            
            .task {
                textArr = text.components(separatedBy: "\n")
            }
    }
}

@available(iOS 16.0, *)
struct textEdit: View {
    @Binding var text:String
    var body: some View {
        TextField("Markdown", text: $text ,axis: .vertical)
    }
}

