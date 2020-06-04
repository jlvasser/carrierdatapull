object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'New Company Data Pull'
  ClientHeight = 447
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Calibri'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnShow = FormShow
  DesignSize = (
    724
    447)
  PixelsPerInch = 96
  TextHeight = 13
  object RzLabel1: TRzLabel
    Left = 32
    Top = 172
    Width = 150
    Height = 19
    Caption = 'Data Date (MonthYear)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object progBarOverall: TRzProgressBar
    Left = 32
    Top = 295
    Width = 229
    Height = 41
    BarStyle = bsGradient
    BorderWidth = 0
    InteriorOffset = 0
    PartsComplete = 0
    Percent = 0
    TotalParts = 21
  end
  object RzLabel2: TRzLabel
    Left = 32
    Top = 272
    Width = 227
    Height = 19
    Caption = 'Overall Progress of Process (steps)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object RzLabel3: TRzLabel
    Left = 32
    Top = 344
    Width = 147
    Height = 19
    Caption = 'Current Table Progress'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object lblDataPath: TLabel
    Left = 32
    Top = 114
    Width = 229
    Height = 19
    Caption = 'Local Data Path (Firebird database)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object btnGetMonthYear: TSpeedButton
    Left = 179
    Top = 197
    Width = 23
    Height = 22
    Hint = 'Click here to set the Data Date value'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000020000
      000A000000100000001100000011000000110000001200000012000000120000
      0012000000120000001300000013000000120000000C000000030000000A8159
      4CC2B47C69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB279
      68FFB27967FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F
      6EFFFBF7F4FFF9F0EBFFFBF5F1FFFBF7F4FFFBF7F4FFF9F3EEFFF7EDE7FFFAF4
      EFFFFBF6F3FFFBF6F3FFF9F3EFFFF6ECE5FFB47B69FF000000110000000EB984
      72FFFBF8F5FFDAD0C9FF776258FF563D32FF553D32FFA3948DFFF8F1ECFF806B
      62FF543B31FF543B30FF7E6961FFF7EDE7FFB77F6EFF000000110000000EBC89
      78FFFCF9F7FFAF9F97FF8F7B71FFF8F0EBFFD9CDC7FF573F33FFC3B5AFFFF8EF
      EAFF97867EFF816E64FFF7EEE8FFF8EEE9FFB98472FF000000100000000DC08E
      7DFFFCFAF8FFFAF3EFFFF9F2EEFFFCF9F7FFE7E0DBFF5A4034FFCEC3BBFFF9F1
      ECFF99887FFF837066FFF8EFEAFFF8F1EBFFBC8977FF000000100000000CC394
      82FFFCFBF9FFFBF5F2FFFBF4F1FF5D4336FF725A4FFFB2A39CFFFAF3EFFFFAF2
      EEFF9B8980FF847268FFF9F2EDFFF9F2EEFFC08E7CFF0000000F0000000BC798
      87FFFDFCFAFFFCF8F5FFFDFAF9FFFBF6F2FFBDB0A9FF7F685EFFFAF4F1FFFCF9
      F6FF9D8C84FF877268FFFAF3F0FFFAF4F0FFC49381FF0000000E0000000BC99D
      8CFFFDFCFBFFD3C9C4FF6D5346FFFEFBFAFFBFB3ADFF614639FFF1EAE7FF8974
      6AFF5F4538FF88746AFFFAF5F2FFFAF6F2FFC69886FF0000000D0000000ACDA1
      90FFFEFDFCFFFCF9F8FF8C786DFF65493AFF63483BFFA18E85FFFCF7F6FFFCF7
      F6FFBEB1AAFF8B756AFFFBF6F5FFFBF7F5FFC99D8BFF0000000D00000009CFA5
      94FFFEFDFDFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9
      F7FFFCF9F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53
      C3FF8D9EECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69
      DCFF5966DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55
      C4FF93A4EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6F
      DEFF5C6CDDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56
      C6FF96A7EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595
      EAFF8291E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A40
      93C14D55C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046
      B7FF3E44B4FF3C41B3FF3A3EB0FF393CAEFF282B80C200000006000000010000
      0004000000060000000600000006000000070000000700000007000000070000
      0007000000070000000800000008000000070000000500000001}
    OnClick = btnGetMonthYearClick
  end
  object lblPrct: TRzLabel
    Left = 300
    Top = 348
    Width = 125
    Height = 15
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Caption = '0%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object lblTotalRecords: TRzLabel
    Left = 584
    Top = 344
    Width = 117
    Height = 19
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TRzLabel
    Left = 32
    Top = 28
    Width = 184
    Height = 23
    Caption = 'Select Target System ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    TextStyle = tsRecessed
  end
  object progBarTable: TProgressBar
    Left = 32
    Top = 369
    Width = 669
    Height = 34
    Anchors = [akLeft, akRight, akBottom]
    Smooth = True
    BarColor = clLime
    Step = 1
    TabOrder = 6
  end
  object ButtonBar: TRzDialogButtons
    Left = 0
    Top = 411
    Width = 724
    CaptionOk = 'Close'
    EnableHelp = False
    CancelCancel = False
    ModalResultOk = 0
    ModalResultCancel = 0
    ShowGlyphs = True
    ShowCancelButton = False
    OnClickOk = ButtonBarClickOk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object btnMakeZip: TBitBtn
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Zip File ...'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000020000
        000A0000000F0000001000000010000000100000001100000011000000110000
        001100000011000000100000000B000000030000000000000000000000094633
        2CC160453BFF644A41FFB87D4EFFB97A4AFFB47444FFB06C3DFFA76436FFA764
        36FF583D36FF5B3E37FF3B2821C20000000A00000000000000000000000D6F53
        47FF947869FF6A4F46FFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A66DFFD4A5
        6AFF5D413AFF684B41FF543931FF0000000E00000000000000000000000C7357
        4AFF987D6EFF70564BFFFFFFFFFFF6EFEAFFF6EFE9FFF6EEE9FFF5EEE9FFF6EE
        E8FF62473FFF715348FF573B33FF0000000F00000000000000000000000B785C
        4EFF9D8273FF765C50FFFFFFFFFFF7F0EBFFF7F0EBFFF7EFEBFFF6EFEAFFF6EF
        EAFF684E44FF72554BFF593E35FF0000000E00000000000000000000000A7C60
        50FFA28777FF7B6154FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFF1F1
        F1FF89756EFF8A7269FF5F443BFF0000000C0000000000000000000000097F63
        54FFA78E7DFF977A6AFF967969FF957967FF84695CFF705548FF8F7B73FF0B67
        37FF295D3CFF81746BFF806C63FF0000000C0000000000000000000000088367
        57FFAB9382FF634A41FF614740FF5E463DFF5C443CFF5B433BFF776761FF0A67
        37FF2AAF7FFF106137FF5B6352FF00000016000000030000000000000007866A
        59FFAF9788FF674E44FFF3EAE4FFE8D9CEFFE9DFD7FFE5DBD5FFD8CFC9FF0B6A
        3BFF4EDCB2FF27C48DFF0C7746FF022E179C000201190000000500000006886D
        5CFFB39C8CFF6B5248FFF4ECE6FFEBE3DCFF47916BFF046B38FF046B38FF056B
        38FF3AD7A5FF37D6A2FF32D3A0FF199966FF044A26D5000D063A000000058B70
        5EFFB7A091FF70564DFFF6EFEAFFEBE4DFFF167E4EFF84EDD1FF52E1B6FF4DDF
        B3FF48DDAFFF44DBACFF3FD9A9FF3AD7A6FF32BE8EFF0F6A3FF6000000048E72
        60FFBBA595FF755A50FFF7F1ECFFF1EEEBFF188252FFB8F7E7FFB4F5E6FFAFF4
        E4FF85EDD2FF52E1B7FF4DDFB3FF5DE2BBFF66D0AEFF16794CF6000000026A56
        49BF8F7361FF795E54FF765D52FFAFA19CFF3B8963FF0D814DFF0D804DFF0D80
        4CFF95F1DAFF65E7C2FF83ECCFFF57B28FFF065932D2010E0832000000010000
        000200000003000000030000000300000005000000090000000C000000140D7B
        4BF2AEF6E5FF94E5CEFF339167FD033A1F910001010F00000003000000000000
        0000000000000000000000000000000000000000000000000000000000070F7F
        4EF287CBB3FF106D42E6011C0F4C000000060000000100000000000000000000
        0000000000000000000000000000000000000000000000000000000000051081
        52F1034B2AAE0007041700000003000000010000000000000000}
      TabOrder = 3
      OnClick = btnMakeZipClick
    end
  end
  object btnStart: TRzBitBtn
    Left = 32
    Top = 236
    Width = 229
    Caption = 'Start Data Retrieval'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 3
    TextStyle = tsRecessed
    OnClick = btnStartClick
  end
  object memoLog: TRzRichEdit
    Left = 288
    Top = 28
    Width = 413
    Height = 305
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    PlainText = True
    ScrollBars = ssVertical
    TabOrder = 5
    WantTabs = True
    Zoom = 100
    FrameStyle = fsNone
  end
  object edtDataDate: TRzEdit
    Left = 32
    Top = 197
    Width = 150
    Height = 23
    Hint = 
      'Click button to right to set the value or type in in the format ' +
      'of MonthYear'
    Text = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TextHint = 'MonthYear'
    TextHintVisibleOnFocus = True
  end
  object edtDataPath: TRzButtonEdit
    Left = 32
    Top = 139
    Width = 225
    Height = 21
    Hint = 'Select the location of the Firebird database to be used.'
    Text = ''
    TabOrder = 1
    TextHint = 'Select Path'
    OnEnter = edtDataPathEnter
    ButtonHint = 
      'Click here to select the location of the Firebird database to be' +
      ' used.'
    AltBtnWidth = 15
    ButtonWidth = 18
    OnButtonClick = edtDataPathButtonClick
  end
  object grpTargetSystem: TRadioGroup
    Left = 32
    Top = 31
    Width = 225
    Height = 78
    Margins.Top = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Items.Strings = (
      'Aspen 3.0 (Firebird)'
      'Aspen 3.2+ (SQLite)')
    ParentFont = False
    TabOrder = 0
    TabStop = True
    OnClick = grpTargetSystemClick
  end
  object dlgDataPath: TRzOpenDialog
    ShowButtonGlyphs = True
    Title = 'Select Target Database'
    Options = [osoFileMustExist, osoPathMustExist, osoAllowTree, osoShowHints, osoOleDrag, osoOleDrop]
    Filter = 'Firebird Database|ISS_FED_DATA.FDB|All Files|*.*'
    DefaultExt = 'FDB'
    Left = 228
    Top = 168
  end
  object menuMain: TMainMenu
    Left = 304
    Top = 36
    object menuFile: TMenuItem
      Caption = '&File'
      object menuFileEnv: TMenuItem
        Caption = '&Environment ...'
        OnClick = menuFileEnvClick
      end
      object menuFileRefTbl: TMenuItem
        Caption = 'Ref Tbl Location ...'
        OnClick = menuFileRefTblClick
      end
      object menuFileZip: TMenuItem
        Caption = 'Make &Zip File ...'
        OnClick = btnMakeZipClick
      end
      object menuFileSeparator1: TMenuItem
        Caption = '-'
      end
      object menuFileExit: TMenuItem
        Caption = 'E&xit'
        OnClick = ButtonBarClickOk
      end
    end
    object menuHelp: TMenuItem
      Caption = '&Help'
      object menuHelpHowTo: TMenuItem
        Caption = '&How To ...'
      end
      object menuHelpSeparator1: TMenuItem
        Caption = '-'
      end
      object menuHelpAbout: TMenuItem
        Caption = '&About ...'
      end
    end
  end
end
