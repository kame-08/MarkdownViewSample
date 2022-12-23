import SwiftUI

@available(iOS 16.0, *)
public struct MarkdownViewSample {
    public private(set) var text = "Hello, World!"
    public private(set) var markdownViewStyle: MarkdownViewStyle
}

@available(iOS 16.0, *)
public struct MarkdownView: View {
    @Binding var text: String
    @State public var markdownViewStyle: MarkdownViewStyle
    public init(text: Binding<String>, markdownViewStyle: MarkdownViewStyle) {
        self._text = text
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
        return Font.title2
    } else if text.prefix(3) == "## " {
        return Font.title
    } else if text.prefix(2) == "# " {
        return Font.largeTitle
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
        HStack {
            VStack(alignment: .leading) {
                ForEach(0 ..< textArr.count, id: \.self) { num in
                    if markdownCheck(textArr[num]) == .largeTitle {
                        VStack{
                            Text(getAttributedString(textArr[num]))
                                .font(.largeTitle)
                            Divider()
                        }
                    } else if markdownCheck(textArr[num]) == .footnote {
                        // URLの時
                        Text(getAttributedString(textArr[num]))
                            .font(.body)
                            .foregroundColor(Color(.link))
                        
                    }else if textArr[num].prefix(2) == "> "  {
                        HStack {
                            Image(systemName: "poweron")
                            Text(getAttributedString(textArr[num]))
                        }
                    }else if textArr[num].prefix(2) == "- " ||  textArr[num].prefix(2) == "* " || textArr[num].prefix(2) == "+ "{
                        HStack {
                            Image(systemName: "circlebadge.fill")
                                .font(.caption2)
                            Text(getAttributedString(textArr[num]))
                        }
                    }else if textArr[num].prefix(2) == "— " || textArr[num].prefix(3) == "-- " || textArr[num].prefix(3) == "__ "{
                        Divider()
                    } else {
                        Text(getAttributedString(textArr[num]))
                            .font(markdownCheck(textArr[num]))
                    }
                }
                .task {
                    textArr = text.components(separatedBy: "\n")
                }
                .onChange(of: text) { newValue in
                    textArr = newValue.components(separatedBy: "\n")
                    print(textArr)
                }
            }
            Spacer()
        }
    }
}

@available(iOS 15, *)
func getAttributedString(_ text:String) -> AttributedString {
    do {
        let attributedString = try AttributedString(markdown: text)
        return attributedString
    } catch {
        print("Couldn't parse: \(error)")
    }
    return AttributedString("Error parsing markdown")
}

@available(iOS 16.0, *)
struct textEdit: View {
    @Binding var text:String
    var body: some View {
        TextField("Markdown", text: $text ,axis: .vertical)
    }
}

