object dlgSelectDataSet: TdlgSelectDataSet
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select Data Set'
  ClientHeight = 376
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnBar: TRzDialogButtons
    Left = 0
    Top = 340
    Width = 290
    HotTrack = True
    TabOrder = 0
  end
  object btnCarrier: TRzBitBtn
    Left = 20
    Top = 8
    Caption = 'Carriers'
    TabOrder = 1
    OnClick = btnCarrierClick
  end
  object btnISS: TRzBitBtn
    Left = 20
    Top = 44
    Caption = 'ISS'
    TabOrder = 2
    OnClick = btnISSClick
  end
  object btnLegalName: TRzBitBtn
    Left = 20
    Top = 80
    Caption = 'Legal Names'
    TabOrder = 3
    OnClick = btnLegalNameClick
  end
  object btnDbaName: TRzBitBtn
    Left = 20
    Top = 116
    Caption = 'DBA Names'
    TabOrder = 4
    OnClick = btnDbaNameClick
  end
  object btnInsurance: TRzBitBtn
    Left = 20
    Top = 152
    Caption = 'Insurance'
    TabOrder = 5
    OnClick = btnInsuranceClick
  end
  object btnBASICs: TRzBitBtn
    Left = 20
    Top = 188
    Caption = 'BASICs'
    TabOrder = 6
    OnClick = btnBASICsClick
  end
  object btnHMpermit: TRzBitBtn
    Left = 20
    Top = 225
    Caption = 'HM Permits'
    TabOrder = 7
    OnClick = btnHMpermitClick
  end
  object progBar: TProgressBar
    Left = 112
    Top = 8
    Width = 153
    Height = 277
    Orientation = pbVertical
    Smooth = True
    Step = 1
    TabOrder = 8
  end
  object btnUCR: TRzBitBtn
    Left = 20
    Top = 260
    Caption = 'UCR'
    TabOrder = 9
    OnClick = btnUCRClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 312
    Width = 290
    Height = 28
    Panels = <
      item
        Alignment = taRightJustify
        Text = 'Record'
        Width = 50
      end
      item
        Alignment = taCenter
        Text = '0'
        Width = 75
      end
      item
        Alignment = taCenter
        Text = 'of'
        Width = 25
      end
      item
        Text = '0'
        Width = 100
      end
      item
        Alignment = taRightJustify
        Text = '0%'
        Width = 25
      end>
  end
end
