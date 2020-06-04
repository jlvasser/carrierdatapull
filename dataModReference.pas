{-----------------------------------------------------------------------------
 Unit Name: dataModReference
 Author:    J. L. Vasser
 Date:      2019-04-29
 Purpose:   Created to have a single, snapshot of USDOT number records to
            reference while building all other tables.
 History:   Created 2019-04-29
-----------------------------------------------------------------------------}
unit dataModReference;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, Uni, UniProvider,
  SQLiteUniProvider;

type
  TdmReference = class(TDataModule)
    dbReference: TUniConnection;
    providerReference: TSQLiteUniProvider;
    qrySnapshot: TUniQuery;
    qrySnapshotUSDOTNUM: TStringField;
    qrySnapshotSTATUS: TStringField;
    qrySnapshotLAST_UPDATE_DATE: TDateTimeField;
    sqlDelete: TUniSQL;
    refTransaction: TUniTransaction;
    qrySnapshotCARRIER_ID_NUMBER: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmReference: TdmReference;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
