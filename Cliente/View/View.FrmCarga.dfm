object frmCarga: TfrmCarga
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Carga em lote'
  ClientHeight = 100
  ClientWidth = 200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 19
  object btnCarregar: TSpeedButton
    Left = 27
    Top = 37
    Width = 145
    Height = 26
    Caption = 'Selecionar Arquivo'
    OnClick = btnCarregarClick
  end
  object OpenDialog1: TOpenDialog
    Filter = 'txt|*.txt'
    Title = 'Lista de insers'#227'o'
    Left = 152
    Top = 39
  end
end
