import SwiftUI

@available(iOS 13.0, *)
public struct MarkdownViewSample {
    public private(set) var text = "Hello, World!"
}

@available(iOS 13.0, *)
public struct MarkdownView: View {
    public init() {
        
    }
    public var body: some View {
        List {
            // 一行目
            Text("item1")
            // 二行目
            Text("item2")
            // 三行目
            Text("item3")
        }
    }
}



