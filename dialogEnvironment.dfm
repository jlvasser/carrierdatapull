object dlgDBEnvironment: TdlgDBEnvironment
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Environment'
  ClientHeight = 164
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object btnBar: TRzDialogButtons
    Left = 0
    Top = 128
    Width = 266
    ShowGlyphs = True
    TabOrder = 0
    ExplicitLeft = 56
    ExplicitTop = 124
    ExplicitWidth = 185
  end
  object grpSelectEnv: TRzRadioGroup
    Left = 8
    Top = 8
    Width = 245
    Caption = 'Select Environment'
    GroupStyle = gsUnderline
    ItemHeight = 22
    ItemIndex = 0
    Items.Strings = (
      'Production (within AWS)'
      'Development (AD DOT)')
    TabOrder = 1
    TextStyle = tsRaised
    OnClick = grpSelectEnvClick
    DesignSize = (
      245
      105)
    object lblSelected: TRzLabel
      Left = 8
      Top = 77
      Width = 225
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'safer.fmcsa.dot.gov'
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
  end
end
