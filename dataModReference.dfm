object dmReference: TdmReference
  OldCreateOrder = False
  Height = 197
  Width = 334
  object dbReference: TUniConnection
    AutoCommit = False
    ProviderName = 'SQLite'
    Database = 
      'C:\Projects\DataPull\carrierdatapull\Win64\Debug\ISSTables/DataP' +
      'ullRef.db'
    SpecificOptions.Strings = (
      'InterBase.UseUnicode=True'
      'SQLite.Direct=True')
    Options.AllowImplicitConnect = False
    Options.KeepDesignConnected = False
    Options.DefaultSortType = stCaseInsensitive
    DefaultTransaction = refTransaction
    Server = 'localhost'
    LoginPrompt = False
    Left = 51
    Top = 16
  end
  object providerReference: TSQLiteUniProvider
    Left = 243
    Top = 16
  end
  object qrySnapshot: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO CARRIERS'
      '  (CARRIER_ID_NUMBER, USDOTNUM, STATUS, LAST_UPDATE_DATE)'
      'VALUES'
      '  (:CARRIER_ID_NUMBER, :USDOTNUM, :STATUS, :LAST_UPDATE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM CARRIERS'
      'WHERE'
      '  CARRIER_ID_NUMBER = :Old_CARRIER_ID_NUMBER')
    SQLUpdate.Strings = (
      'UPDATE CARRIERS'
      'SET'
      
        '  CARRIER_ID_NUMBER = :CARRIER_ID_NUMBER, USDOTNUM = :USDOTNUM, ' +
        'STATUS = :STATUS, LAST_UPDATE_DATE = :LAST_UPDATE_DATE'
      'WHERE'
      '  CARRIER_ID_NUMBER = :Old_CARRIER_ID_NUMBER')
    SQLRefresh.Strings = (
      
        'SELECT CARRIER_ID_NUMBER, USDOTNUM, STATUS, LAST_UPDATE_DATE FRO' +
        'M CARRIERS'
      'WHERE'
      '  CARRIER_ID_NUMBER = :CARRIER_ID_NUMBER')
    SQLRecCount.Strings = (
      'SELECT count(*) FROM (SELECT * FROM CARRIERS'
      ')')
    SmartFetch.Enabled = True
    Connection = dbReference
    ParamCheck = False
    SQL.Strings = (
      'SELECT CARRIER_ID_NUMBER, USDOTNUM, STATUS, LAST_UPDATE_DATE'
      '  FROM CARRIERS'
      'ORDER BY CARRIER_ID_NUMBER')
    FetchRows = 250
    Options.TrimVarChar = True
    Options.RequiredFields = False
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.LongStrings = False
    Options.RemoveOnRefresh = False
    SpecificOptions.Strings = (
      'InterBase.AutoCommit=False')
    AutoCalcFields = False
    Left = 51
    Top = 88
    object qrySnapshotCARRIER_ID_NUMBER: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CARRIER_ID_NUMBER'
    end
    object qrySnapshotUSDOTNUM: TStringField
      DisplayLabel = 'USDOT #'
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object qrySnapshotSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Size = 1
    end
    object qrySnapshotLAST_UPDATE_DATE: TDateTimeField
      DisplayLabel = 'Last Update'
      FieldName = 'LAST_UPDATE_DATE'
    end
  end
  object sqlDelete: TUniSQL
    Connection = dbReference
    SQL.Strings = (
      'delete from CARRIERS'
      '')
    Left = 140
    Top = 84
  end
  object refTransaction: TUniTransaction
    DefaultConnection = dbReference
    Left = 140
    Top = 16
  end
end
