object Form5: TForm5
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Demo - DTFBRepair'
  ClientHeight = 289
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 129
    Height = 13
    Caption = 'Caminho da base de dados'
  end
  object Button1: TButton
    Left = 340
    Top = 22
    Width = 113
    Height = 25
    Cursor = crHandPoint
    Caption = 'Restaura DataBase'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 297
    Height = 21
    TabOrder = 1
  end
  object Button2: TButton
    Left = 301
    Top = 22
    Width = 33
    Height = 25
    Cursor = crHandPoint
    Caption = '...'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 64
    Width = 445
    Height = 214
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object DTFBRepair1: TDTFBRepair
    OnRepair = DTFBRepair1Repair
    Left = 336
    Top = 88
  end
  object OpenDialog1: TOpenDialog
    Left = 224
    Top = 88
  end
end
