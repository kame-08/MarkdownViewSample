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
            arrText = text.components(separatedBy: "\n")
        }
        .onChange(of: text) { newValue in
            arrText = newValue.components(separatedBy: "\n")
        }
    }

}

@available(iOS 16.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Markdown(.constant("# Apple"))
    }
}
