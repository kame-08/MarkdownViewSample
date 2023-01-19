//
//  File.swift
//  
//
//  Created by Ryo on 2023/01/19.
//

import Foundation

func MarkdownArray(text: String) -> [String] {
    var Newline = text.split(whereSeparator: \.isNewline)
    var Array:[String] = []
    var isCoodeBlock = false
    var temCode = ""

    for code in Newline {
        if code == "```" {
            if isCoodeBlock {
                // コードブロック終了
                temCode += code
                Array += [temCode]
                temCode = ""
                isCoodeBlock = false
                // "```"が2つ入らないように
                continue
            } else {
                // コードブロック開始
                isCoodeBlock = true
            }
        }
        if isCoodeBlock == true {
            // コードブロック中
            temCode += code + "\n"
        } else {
            // コードブロック以外
            Array += [String(code)]
        }
    }
    return Array
}
