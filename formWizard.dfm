object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Carrier Data Pull Wizard'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object wizCtrl: TdxWizardControl
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    AutoSize = True
    Buttons.CustomButtons.Buttons = <>
    Header.AssignedValues = [wchvDescriptionFont, wchvTitleFont]
    Header.DescriptionFont.Charset = DEFAULT_CHARSET
    Header.DescriptionFont.Color = clDefault
    Header.DescriptionFont.Height = -13
    Header.DescriptionFont.Name = 'Calibri'
    Header.DescriptionFont.Style = []
    Header.TitleFont.Charset = DEFAULT_CHARSET
    Header.TitleFont.Color = clDefault
    Header.TitleFont.Height = -12
    Header.TitleFont.Name = 'Arial'
    Header.TitleFont.Style = []
    InfoPanel.Caption = 'Carrier Data Pull Wizard'
    OptionsViewStyleAero.Title.Text = 'OptionViewStyleText'
    OnButtonClick = wizCtrlButtonClick
    OnPageChanged = wizCtrlPageChanged
    object WizPage_Home: TdxWizardControlPage
      Header.AssignedValues = [wchvDescriptionFont, wchvTitleFont]
      Header.DescriptionFont.Charset = DEFAULT_CHARSET
      Header.DescriptionFont.Color = clDefault
      Header.DescriptionFont.Height = -13
      Header.DescriptionFont.Name = 'Calibri'
      Header.DescriptionFont.Style = []
      Header.TitleFont.Charset = DEFAULT_CHARSET
      Header.TitleFont.Color = clDefault
      Header.TitleFont.Height = -16
      Header.TitleFont.Name = 'Arial'
      Header.TitleFont.Style = []
      Header.Description = 
        'This Wizard will create monthly carrier data update files for As' +
        'pen version 3.0 and 3.2+'
      Header.Title = 'Carrier Data Pull Wizard'
      DesignSize = (
        618
        334)
      object cxMemo1: TcxMemo
        Left = 12
        Top = 8
        TabStop = False
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          
            'This Wizard will guide you through the steps of creating the mon' +
            'thly Carrier '
          
            'Data Update file, also known as the ISS data file, used by Aspen' +
            ' Inspection '
          
            'software.  This wizard will allow creation of the file in both A' +
            'spen 3.0 format '
          
            '(Firebird database) and Aspen 3.2(+) format using a SQLite datab' +
            'ase.'
          '  '
          'Click the "Next" button to begin.')
        ParentFont = False
        Properties.ReadOnly = True
        Style.Edges = []
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -19
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = True
        Style.TransparentBorder = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        StyleFocused.LookAndFeel.Kind = lfUltraFlat
        StyleFocused.LookAndFeel.NativeStyle = False
        StyleHot.LookAndFeel.Kind = lfUltraFlat
        StyleHot.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Height = 301
        Width = 603
      end
    end
    object WizPage_Target: TdxWizardControlPage
      Header.AssignedValues = [wchvDescriptionFont, wchvTitleFont]
      Header.DescriptionFont.Charset = DEFAULT_CHARSET
      Header.DescriptionFont.Color = clDefault
      Header.DescriptionFont.Height = -13
      Header.DescriptionFont.Name = 'Calibri'
      Header.DescriptionFont.Style = []
      Header.TitleFont.Charset = DEFAULT_CHARSET
      Header.TitleFont.Color = clDefault
      Header.TitleFont.Height = -16
      Header.TitleFont.Name = 'Arial'
      Header.TitleFont.Style = []
      Header.Description = 'Select the intended inspection system'
      Header.Title = 'Target System'
      object grpTargetSystem: TcxRadioGroup
        Left = 44
        Top = 39
        ParentFont = False
        Properties.Items = <
          item
            Caption = 'Aspen 3.0 (Firebird)'
          end
          item
            Caption = 'Aspen 3.2 (+) (SQLite)'
          end>
        Style.BorderStyle = ebsNone
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -15
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = True
        Style.Shadow = False
        Style.TextStyle = []
        Style.IsFontAssigned = True
        StyleDisabled.BorderStyle = ebsNone
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = True
        TabOrder = 0
        OnClick = grpTargetSystemClick
        Height = 116
        Width = 185
      end
      object lblTargetSystem: TcxLabel
        Left = 44
        Top = 28
        Caption = 'Select Target System and Data Format'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -16
        Style.Font.Name = 'Calibri'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
      end
    end
    object WizPage_DataDate: TdxWizardControlPage
      Header.AssignedValues = [wchvTitleFont]
      Header.TitleFont.Charset = DEFAULT_CHARSET
      Header.TitleFont.Color = clDefault
      Header.TitleFont.Height = -16
      Header.TitleFont.Name = 'Arial'
      Header.TitleFont.Style = []
      Header.Description = 
        'Click the Calendar Button below to set the  current month and ye' +
        'ar as the data date'
      Header.Title = 'Set the Data Date'
      object btnGetMonthYear: TSpeedButton
        Left = 180
        Top = 105
        Width = 85
        Height = 22
        Hint = 'Click here to set the Data Date value'
        Caption = 'Click here'
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
      object lblPage1: TcxLabel
        Left = 24
        Top = 40
        Caption = 'Select Month and Year for Data Exctract'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -16
        Style.Font.Name = 'Calibri'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
      end
      object lblDate: TcxLabel
        Left = 24
        Top = 80
        Caption = 'Data Date (MonthYear)'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object edtDataDate: TcxTextEdit
        Left = 24
        Top = 105
        Hint = 'Click button to right to set the value'
        TabStop = False
        ParentFont = False
        Properties.AutoSelect = False
        Properties.IncrementalSearch = False
        Properties.ReadOnly = True
        Properties.OnChange = edtDataDatePropertiesChange
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        TextHint = 'MonthYear'
        Width = 150
      end
    end
    object WizPage_DataLocation: TdxWizardControlPage
      Header.AssignedValues = [wchvDescriptionFont, wchvTitleFont]
      Header.DescriptionFont.Charset = DEFAULT_CHARSET
      Header.DescriptionFont.Color = clDefault
      Header.DescriptionFont.Height = -13
      Header.DescriptionFont.Name = 'Calibri'
      Header.DescriptionFont.Style = []
      Header.TitleFont.Charset = DEFAULT_CHARSET
      Header.TitleFont.Color = clDefault
      Header.TitleFont.Height = -16
      Header.TitleFont.Name = 'Arial'
      Header.TitleFont.Style = []
      Header.Description = 'This is the location of the local TARGET database'
      Header.Title = 'Data Location'
      object lblDataLocation: TcxLabel
        Left = 20
        Top = 152
        Caption = 'Select the location of the LOCAL ISS Database'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -16
        Style.Font.Name = 'Calibri'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
      end
      object edtDataPath: TcxButtonEdit
        Left = 24
        Top = 193
        TabStop = False
        ParentFont = False
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Caption = 'Click Here'
            Default = True
            Hint = 'Click here to select database director'
            Kind = bkEllipsis
            Width = 25
          end>
        Properties.IncrementalSearch = False
        Properties.ReadOnly = True
        Properties.OnButtonClick = edtDataPathPropertiesButtonClick
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        TextHint = '..\data\path'
        Width = 561
      end
      object edtRefDataPath: TcxButtonEdit
        Left = 24
        Top = 79
        TabStop = False
        ParentFont = False
        Properties.AutoSelect = False
        Properties.Buttons = <
          item
            Caption = 'Click Here'
            Default = True
            Hint = 'Click here to select database director'
            Kind = bkEllipsis
            Width = 25
          end>
        Properties.IncrementalSearch = False
        Properties.ReadOnly = True
        Properties.OnButtonClick = edtRefDataPathPropertiesButtonClick
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        TextHint = '..\data\path'
        Width = 561
      end
      object lblRefData: TcxLabel
        Left = 24
        Top = 42
        Caption = 'Select the location of the Wizard Reference Database'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -16
        Style.Font.Name = 'Calibri'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
      end
    end
    object WizPage_StartProcess: TdxWizardControlPage
      Header.AssignedValues = [wchvDescriptionFont, wchvTitleFont]
      Header.DescriptionFont.Charset = DEFAULT_CHARSET
      Header.DescriptionFont.Color = clDefault
      Header.DescriptionFont.Height = -13
      Header.DescriptionFont.Name = 'Calibri'
      Header.DescriptionFont.Style = []
      Header.TitleFont.Charset = DEFAULT_CHARSET
      Header.TitleFont.Color = clDefault
      Header.TitleFont.Height = -16
      Header.TitleFont.Name = 'Arial'
      Header.TitleFont.Style = []
      Header.Description = 'Review Settings and press the Start button when ready'
      Header.Title = 'Confirm Selections'
      object lblConfirmTarget: TcxLabel
        Left = 32
        Top = 48
        Caption = 'Target System'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object lblTargetDataDate: TcxLabel
        Left = 32
        Top = 101
        Caption = 'Data Date'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object lblDataPath: TcxLabel
        Left = 32
        Top = 208
        Caption = 'Local Data Path'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object radBtnConfirmFB: TcxRadioButton
        Left = 176
        Top = 48
        Width = 130
        Height = 17
        Caption = 'Aspen 3.0 (Firebird DB)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        GroupIndex = 1
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
      end
      object radBtnConfirmSQLite: TcxRadioButton
        Left = 338
        Top = 48
        Width = 130
        Height = 17
        Caption = 'Aspen 3.2(+) SQLite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        GroupIndex = 1
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
      end
      object edtConfirmDate: TcxTextEdit
        Left = 176
        Top = 100
        TabStop = False
        ParentFont = False
        Properties.AutoSelect = False
        Properties.IncrementalSearch = False
        Properties.ReadOnly = True
        Properties.UseLeftAlignmentOnEditing = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 5
        Width = 173
      end
      object edtConfirmDataPath: TcxTextEdit
        Left = 32
        Top = 233
        TabStop = False
        ParentFont = False
        Properties.AutoSelect = False
        Properties.IncrementalSearch = False
        Properties.ReadOnly = True
        Properties.UseLeftAlignmentOnEditing = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 6
        Width = 569
      end
      object btnConfirmed: TcxButton
        Left = 242
        Top = 269
        Width = 107
        Height = 37
        Caption = 'Confirmed'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
          462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
          617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
          2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
          77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
          22307078222076696577426F783D2230203020333220333222207374796C653D
          22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
          3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
          303B3C7374796C6520747970653D22746578742F6373732220786D6C3A737061
          63653D227072657365727665223E2E477265656E7B66696C6C3A233033394332
          333B7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A233732
          373237323B7D262331333B262331303B2623393B2E5265647B66696C6C3A2344
          31314331433B7D262331333B262331303B2623393B2E59656C6C6F777B66696C
          6C3A234646423131353B7D262331333B262331303B2623393B2E426C75657B66
          696C6C3A233131373744373B7D262331333B262331303B2623393B2E57686974
          657B66696C6C3A234646464646463B7D262331333B262331303B2623393B2E73
          74307B6F7061636974793A302E353B7D262331333B262331303B2623393B2E73
          74317B6F7061636974793A302E37353B7D3C2F7374796C653E0D0A3C67206964
          3D224564697445787472616374536F75726365223E0D0A09093C706174682063
          6C6173733D2259656C6C6F772220643D224D31362C313763302C302E352D302E
          352C312D312C314836763763302C312E352C332E312C322E372C372E322C322E
          394C32342C31372E32563963302D312E352D332E352D322E382D382D33563137
          7A222F3E0D0A09093C7061746820636C6173733D22426C75652220643D224D32
          392C32336C2D382C386C2D342D346C382D384C32392C32337A204D33302C3232
          6C312E372D312E3763302E342D302E342C302E342D312C302D312E334C32392C
          31362E33632D302E342D302E342D312D302E342D312E332C304C32362C31384C
          33302C32327A20202623393B2623393B204D31362C3238763468344C31362C32
          387A222F3E0D0A09093C7061746820636C6173733D22426C61636B2220643D22
          4D31322C31302E385631344832563468382E326C322D32483143302E352C322C
          302C322E352C302C3376313263302C302E352C302E352C312C312C3168313263
          302E352C302C312D302E352C312D3156382E384C31322C31302E387A222F3E0D
          0A09093C706F6C79676F6E20636C6173733D22477265656E2220706F696E7473
          3D22342C3520342C3820382C31322031362C342031362C3120382C3920262339
          3B222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
        TabOrder = 7
        OnClick = btnConfirmedClick
      end
      object lblRefDataPath: TcxLabel
        Left = 32
        Top = 154
        Caption = 'Reference Data Path'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
      object edtConfirmRefPath: TcxTextEdit
        Left = 32
        Top = 177
        TabStop = False
        ParentFont = False
        Properties.AutoSelect = False
        Properties.IncrementalSearch = False
        Properties.ReadOnly = True
        Properties.UseLeftAlignmentOnEditing = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -12
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 9
        Width = 569
      end
    end
    object WizPage_Processing: TdxWizardControlPage
      Header.AssignedValues = [wchvTitleFont]
      Header.TitleFont.Charset = DEFAULT_CHARSET
      Header.TitleFont.Color = clDefault
      Header.TitleFont.Height = -16
      Header.TitleFont.Name = 'Arial'
      Header.TitleFont.Style = []
      Header.Description = 'Observe the progress of the process here'
      Header.Title = 'Data Pull Progress'
      DesignSize = (
        618
        334)
      object progBarTable: TRzProgressBar
        Left = 3
        Top = 40
        Width = 274
        Height = 29
        BorderWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold, fsItalic]
        InteriorOffset = 0
        ParentFont = False
        PartsComplete = 0
        Percent = 0
        TotalParts = 0
      end
      object progBarOverall: TRzProgressBar
        Left = 3
        Top = 272
        Width = 277
        Height = 29
        BorderWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold, fsItalic]
        InteriorOffset = 0
        ParentFont = False
        PartsComplete = 0
        Percent = 0
        TotalParts = 20
      end
      object lblOverallProgress: TcxLabel
        Left = 3
        Top = 247
        Caption = 'Overall Progress of Process (steps)'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
      end
      object lblTableProgress: TcxLabel
        Left = 0
        Top = 15
        Caption = 'Current Table Progress'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Orientation = cxoLeftBottom
      end
      object lblTotalRecords: TcxLabel
        Left = 230
        Top = 15
        Anchors = [akRight, akBottom]
        AutoSize = False
        Caption = '0'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Calibri'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taRightJustify
        Height = 18
        Width = 50
        AnchorX = 280
      end
      object memoLog: TMemo
        Left = 295
        Top = 0
        Width = 322
        Height = 331
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object dlgDataPath: TRzOpenDialog
    ShowButtonGlyphs = True
    Title = 'Select Target Database'
    Options = [osoFileMustExist, osoPathMustExist, osoAllowTree, osoShowHints, osoOleDrag, osoOleDrop]
    Filter = 'Firebird Database|ISS_FED_DATA.FDB|All Files|*.*'
    DefaultExt = 'FDB'
    Left = 504
    Top = 200
  end
end
