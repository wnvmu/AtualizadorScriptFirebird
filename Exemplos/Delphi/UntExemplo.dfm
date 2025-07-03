object UIExemplo: TUIExemplo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Projeto Atualizar Script SQL'
  ClientHeight = 159
  ClientWidth = 239
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 203
    Height = 65
    Caption = 'Atualizar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnAtualizarRegistrado: TButton
    Left = 16
    Top = 112
    Width = 203
    Height = 25
    Caption = 'Atualizar por registro de DLL'
    TabOrder = 0
    OnClick = BtnAtualizarRegistradoClick
  end
end
