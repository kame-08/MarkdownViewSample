import SwiftUI

@available(iOS 14.0, *)
public struct MarkdownViewSample {
    public private(set) var text = "Hello, World!"
}

@available(iOS 14.0, *)
public struct MarkdownView: View {
    @State var text = ""
    public init() {
        
    }
    
    public var body: some View {
        if text.prefix(4) == "### "{
            TextField("Markdown", text: $text)
                .font(.title3)
//            Text(text)
        } else if text.prefix(3) == "## "{
            TextField("Markdown", text: $text)
                .font(.title2)
//            Text(text)
        } else if text.prefix(2) == "# "{
            TextField("Markdown", text: $text)
//            Text(text)
                .font(.title)
        } else if text.prefix(8) == "https://" {
            //            Text(text)
            TextField("Markdown", text: $text)
                .foregroundColor(Color.blue)
            
        } else {
            TextField("Markdown", text: $text)
        }
    }
}
