//
//  SwiftUIView.swift
//  
//
//  Created by Ryo on 2023/01/10.
//

import SwiftUI

@available(iOS 16.0, *)
public struct Markdown: View {
    @Binding var text: String
    @State var arrText: [String] = []
    
    public init(_ text: Binding<String>) {
        // _text = State(initialValue: text)
        self._text = text
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0.0) {
                ForEach(arrText, id: \.self, content: { atext in
                    if TextStyle(text: atext) == .delimiter {
                        Divider()
                    } else if TextStyle(text: atext) == .image {
                        AsyncImage(url: atext.getImageURL()) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 4.0)
                        } placeholder: {
                            HStack {
                                ProgressView()
                                // 代替テキスト
                                Text(atext.getAttributedString())
                            }
                        }
                    } else if TextStyle(text: atext) == .itemization {
                        HStack {
                            Circle()
                                .frame(width: 5)
                            
                            Text(atext.getAttributedString())
                        }
                        
                    } else if TextStyle(text: atext) == .reference {
                        HStack {
                            Rectangle()
                                .foregroundColor(.orange)
                                .frame(width: 5, height: 0.0)
                            Text(atext.getAttributedString())
                        }
                        .background(
                            HStack {
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: 5)
                                    .frame(maxHeight: .infinity)
                                Spacer()
                            }
                        )
                        
                    } else if TextStyle(text: atext) == .num{
                        HStack {
                            Text("\(atext.getNum())")
                                .font(.system(.body, design: .monospaced))
                            Text(atext.getAttributedString())
                        }
                        
                    }else if TextStyle(text: atext) == .code{
                        HStack {
                            Text(atext.getAttributedString())
                                .font(.system(.body, design: .monospaced))
                        }
                        
                    } else {
                        Text(atext.getAttributedString())
                            .font(TextStyle(text: atext))
                    }
                    
                })
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        .task {
            arrText = MarkdownArray(text: text)
        }
        .onChange(of: text) { newValue in
            arrText = MarkdownArray(text: newValue)
        }
    }
}

@available(iOS 16.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Markdown(.constant("""
# 見出し1
## 見出し2
### 見出し3
#### 見出し4
##### 見出し5
###### 見出し6
- リスト
* リスト
1. 番号付きリスト
2. 番号付きリスト
[記事](https://zenn.dev/ryo_dev)
![アイコン](https://storage.googleapis.com/zenn-user-upload/avatar/8cb73f5e8f.jpeg)
```
コードブロック
```
> 引用
脚注[^1]
インライン^[その2]
[^1]: 脚注の内容その1
[^2]: a
*イタリック*
**太字**
~~打ち消し線~~
インライン`code`
"""))
    }
}
