object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste Delphi Cliente'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 19
  object pLateral: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 600
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object btmPessoas: TSpeedButton
      Left = 0
      Top = 8
      Width = 160
      Height = 24
      Caption = 'Pessoas'
      OnClick = btmPessoasClick
    end
    object btnCarregar: TSpeedButton
      Left = 0
      Top = 38
      Width = 160
      Height = 26
      Caption = 'Ins. Lote Assincrono'
      OnClick = btnCarregarClick
    end
    object btnAtualizarEnderecos: TSpeedButton
      Left = 0
      Top = 70
      Width = 160
      Height = 26
      Caption = 'Atualizar Endere'#231'os'
      OnClick = btnAtualizarEnderecosClick
    end
  end
end
