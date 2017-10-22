object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #21322#35282'/'#20840#35282#22793#25563
  ClientHeight = 217
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object KanaLabel: TLabel
    Left = 8
    Top = 8
    Width = 54
    Height = 13
    Caption = #12459#12479#12459#12490'(&K):'
  end
  object AlphaLabel: TLabel
    Left = 8
    Top = 56
    Width = 43
    Height = 13
    Caption = #33521#23383'(&A):'
  end
  object NumLabel: TLabel
    Left = 8
    Top = 104
    Width = 43
    Height = 13
    Caption = #25968#23383'(&N):'
  end
  object MarksLabel: TLabel
    Left = 136
    Top = 8
    Width = 44
    Height = 13
    Caption = #35352#21495'(&M):'
  end
  object SpacesLabel: TLabel
    Left = 136
    Top = 56
    Width = 42
    Height = 13
    Caption = #31354#30333'(&S):'
  end
  object KanaComboBox: TComboBox
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = #29694#29366#12393#12362#12426
    Items.Strings = (
      #29694#29366#12393#12362#12426
      #20840#35282#12395#22793#25563
      #21322#35282#12395#22793#25563)
  end
  object AlphaComboBox: TComboBox
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = #29694#29366#12393#12362#12426
    Items.Strings = (
      #29694#29366#12393#12362#12426
      #20840#35282#12395#22793#25563
      #21322#35282#12395#22793#25563)
  end
  object NumComboBox: TComboBox
    Left = 8
    Top = 120
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = #29694#29366#12393#12362#12426
    Items.Strings = (
      #29694#29366#12393#12362#12426
      #20840#35282#12395#22793#25563
      #21322#35282#12395#22793#25563)
  end
  object MarksComboBox: TComboBox
    Left = 136
    Top = 24
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 3
    Text = #29694#29366#12393#12362#12426
    Items.Strings = (
      #29694#29366#12393#12362#12426
      #20840#35282#12395#22793#25563
      #21322#35282#12395#22793#25563)
  end
  object SpacesComboBox: TComboBox
    Left = 136
    Top = 72
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = #29694#29366#12393#12362#12426
    Items.Strings = (
      #29694#29366#12393#12362#12426
      #20840#35282#12395#22793#25563
      #21322#35282#12395#22793#25563)
  end
  object RangeGroupBox: TGroupBox
    Left = 136
    Top = 104
    Width = 121
    Height = 65
    Caption = #31684#22258
    TabOrder = 5
    object AllRadioButton: TRadioButton
      Left = 8
      Top = 20
      Width = 105
      Height = 17
      Caption = #25991#31456#20840#20307'(&L)'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object SelRadioButton: TRadioButton
      Left = 8
      Top = 40
      Width = 105
      Height = 17
      Caption = #36984#25246#31684#22258#12398#12415'(&E)'
      TabOrder = 1
    end
  end
  object OKButton: TButton
    Left = 88
    Top = 184
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object CancelButton: TButton
    Left = 176
    Top = 184
    Width = 81
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 7
  end
end
