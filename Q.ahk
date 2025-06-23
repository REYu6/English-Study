^q::  ; Ctrl+Q 触发
ClipSaved := ClipboardAll
Clipboard := ""
Send, ^c
ClipWait, 1

word := Trim(Clipboard)
if RegExMatch(word, "^[a-zA-Z\-']+$")  ; 只接受英文单词（含'-或'）
{
    filePath := A_Desktop . "\recorded_words.txt"
    
    ; 读取现有内容，获取当前最大序号
    lineCount := 0
    if FileExist(filePath) {
        Loop, Read, %filePath%
        {
            if RegExMatch(A_LoopReadLine, "^\d+\.\s") {
                lineCount++
            }
        }
    }

    ; 写入新单词
    FileAppend, % (lineCount + 1) . ". " . word . "`r`n", %filePath%
    ToolTip, ✅ 记录成功: %word%
    SetTimer, RemoveTooltip, -1000
}
else
{
    ToolTip, ❌ 未检测到有效英文单词
    SetTimer, RemoveTooltip, -1000
}

Clipboard := ClipSaved
return

RemoveTooltip:
ToolTip
return
