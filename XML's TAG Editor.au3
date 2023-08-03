#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         Rubens Gomes

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <String.au3>

$nomeApp = "XML's TAG Editor (Domicile)"

$Form1 = GUICreate($nomeApp, 522, 268, 500, 357)
$btnSair = GUICtrlCreateButton("Sair", 408, 216, 75, 25)
$aLista = GUICtrlCreateList("", 32, 48, 337, 188)
$btnProcurar = GUICtrlCreateButton("Procurar", 296, 16, 75, 25)
$pastaInput = GUICtrlCreateInput("", 32, 16, 257, 25)
$pastaInput2 = GUICtrlCreateInput("", 0, 0, 0, 0)
GUISetState(@SW_SHOW)

Local $aConfigs, $aPasta, $listaPDF

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $btnProcurar
            $aPasta = FileSelectFolder ("Procurar", @ScriptDir)
                GUICtrlSetData ($pastaInput, $aPasta)
                $listaPDF = _FileListToArray($aPasta, "*.XML")
            For $i = 1 To $listaPDF[0]
				$sFileRad = FileRead($aPasta & "\" & $listaPDF[$i])
				$sTagNome = _StringBetween($sFileRad, "<xNome>", "</xNome>")
				$sTagNf = _StringBetween($sFileRad, "<nNF>", "</nNF>")
				$sTagPed = _StringBetween($sFileRad, "Pedido Saida N", "   ")
				GUICtrlSetData($aLista, $listaPDF[$i] & " / " & StringStripWS($sTagPed[0], 1) & " / " & $sTagNome[1])
				_ReplaceStringInFile($aPasta & "\" & $listaPDF[$i], "<nNF>0</nNF>", "<nNF>" & StringStripWS($sTagPed[0], 1) & "</nNF>", 0, 0)
			Next
			MsgBox(64, "XML's TAG Editor (Domicile)", "Processo finalizado!")
		Case $btnSair
			Exit
        Case $GUI_EVENT_CLOSE
			Exit
    EndSwitch
WEnd
