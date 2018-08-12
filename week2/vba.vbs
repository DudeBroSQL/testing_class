Sub loopThru()

Dim ws As Worksheet
Dim a As Long
Dim i As Long
Dim t As String
Dim total As Long
Dim shtRng As String
Dim ECel  'Ending Cell
Dim ECel2  'Ending Cell2

For Each ws In Worksheets
ws.Activate
    ECel = Cells(Rows.Count, 1).End(xlUp).Row
    ECel2 = Cells(Rows.Count, 9).End(xlUp).Row
    ActiveSheet.Range(Cells(2, 1), Cells(ECel, 1)).AdvancedFilter Action:=xlFilterCopy, CopyToRange:=ActiveSheet.Range("I2"), Unique:=True
    Range("I1").Value = "Ticker"
    Range("J1").Value = "TotalVolume"
    For i = 2 To 4 'ECel2
        t = Cells(i, 9).Value
        total = 0
        For a = 2 To ECel
            If t = Cells(a, 1) Then
                total = total + CLng(Cells(i, 7).Value)
            End If
        Cells(i, 10).Value = total
        Next
    Next
Next

End Sub