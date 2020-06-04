unit dataModISS_SQLite;

interface

uses
  System.SysUtils, System.Classes, UniProvider, SQLiteUniProvider, Data.DB,
  MemDS, DBAccess, Uni, DAScript, UniScript, System.StrUtils, System.UITypes,
  Dialogs, Vcl.Forms;

type
  TdmISS_SQLite = class(TDataModule)
    dbISS_Local: TUniConnection;
    tblCarriers: TUniTable;
    tblISS: TUniTable;
    tblCarrName: TUniTable;
    tblName2: TUniTable;
    tblHMPermit: TUniTable;
    tblCarrIns: TUniTable;
    tblUCR: TUniTable;
    providerISS_Local: TSQLiteUniProvider;
    tblDataDate: TUniTable;
    tblUpdateStatus: TUniTable;
    srcUpdateStatus: TUniDataSource;
    qryV_CarrierInfo: TUniQuery;
    qryGenValue: TUniQuery;
    sqlDelete: TUniSQL;
    sqlDataDate: TUniSQL;
    sqlEnableIdx: TUniSQL;
    scriptInactivateIndex: TUniScript;
    scriptEnableIdx: TUniScript;
    transactionLocal: TUniTransaction;
    tblCarriersUSDOTNUM: TStringField;
    tblCarriersADDRESS: TStringField;
    tblCarriersZIPCODE: TStringField;
    tblCarriersCOUNTRY: TStringField;
    tblCarriersPHONE: TStringField;
    tblCarriersICC_NUM: TStringField;
    tblCarriersRFC_NUM: TStringField;
    tblCarriersINSPECTION_VALUE: TStringField;
    tblCarriersINDICATOR: TStringField;
    tblCarriersTOTAL_VEHICLES: TIntegerField;
    tblCarriersTOTAL_DRIVERS: TIntegerField;
    tblCarriersCARRIER_OPERATION: TStringField;
    tblCarriersNEW_ENTRANT_CODE: TStringField;
    tblCarriersSTATUS: TStringField;
    tblCarriersLAST_UPDATE_DATE: TDateTimeField;
    tblCarriersENTITY_TYPE: TStringField;
    tblCarriersUNDELIVERABLE_PA: TStringField;
    tblCarriersUNDELIVERABLE_MA: TStringField;
    tblCarriersHAS_POWER_UNITS: TStringField;
    tblCarriersOPER_AUTH_STATUS: TStringField;
    tblCarriersOOS_DATE: TDateField;
    tblCarriersOOS_TEXT: TStringField;
    tblCarriersOOS_REASON: TStringField;
    tblCarriersMCSIP_STATUS: TStringField;
    tblCarriersCountryCalc: TStringField;
    tblISSUSDOTNUM: TStringField;
    tblISSTOTAL_INSPECTIONS: TStringField;
    tblISSVEHICLE_INSPECTIONS: TStringField;
    tblISSDRIVER_INSPECTIONS: TStringField;
    tblISSHAZMAT_INSPECTIONS: TStringField;
    tblISSOOS_TOTAL: TStringField;
    tblISSOOS_VEHICLE: TStringField;
    tblISSOOS_DRIVER: TStringField;
    tblISSSAFETY_RATING: TStringField;
    tblISSRATING_DATE: TDateField;
    tblISSVIOL_BRAKES: TStringField;
    tblISSVIOL_WHEELS: TStringField;
    tblISSVIOL_STEERING: TStringField;
    tblISSVIOL_MEDICAL: TStringField;
    tblISSVIOL_LOGS: TStringField;
    tblISSVIOL_HOURS: TStringField;
    tblISSVIOL_DISQUAL: TStringField;
    tblISSVIOL_DRUGS: TStringField;
    tblISSVIOL_TRAFFIC: TStringField;
    tblISSVIOL_HMPAPER: TStringField;
    tblISSVIOL_HMPLAC: TStringField;
    tblISSVIOL_HMOPER: TStringField;
    tblISSVIOL_HMTANK: TStringField;
    tblISSVIOL_HMOTHR: TStringField;
    tblISSVehicleOOSRate: TFloatField;
    tblISSDriverOOSRate: TFloatField;
    tblISSVehicleOOSPercent: TFloatField;
    tblISSDriverOOSPercent: TFloatField;
    tblISSInspPerVehicle: TFloatField;
    tblISSInspPerDriver: TFloatField;
    tblISSv1BrakesRate: TFloatField;
    tblISSv1WheelRate: TFloatField;
    tblISSv1SteerRate: TFloatField;
    tblISSv1MedicalRate: TFloatField;
    tblISSv1LogsRate: TFloatField;
    tblISSv1HoursRate: TFloatField;
    tblISSv1DQRate: TFloatField;
    tblISSv1DrugsRate: TFloatField;
    tblISSv1TrafficRate: TFloatField;
    tblISSv1HMPaperRate: TFloatField;
    tblISSv1HMPlacRate: TFloatField;
    tblISSv1HMOperRate: TFloatField;
    tblISSv1HMTankRate: TFloatField;
    tblISSv1HMOthrRate: TFloatField;
    tblUCRUCR_SEQ_NUM: TIntegerField;
    tblUCRUSDOTNUM: TStringField;
    tblUCRBASE_STATE: TStringField;
    tblUCRPAYMENT_FLAG: TStringField;
    tblUCRREGISTRATION_YEAR: TStringField;
    tblUCRPAYMENT_DATE: TDateField;
    tblUCRINTRASTATE_VEHICLES: TStringField;
    tblUCRINTRA_VEH_TEXT: TStringField;
    tblUCRPAY_FLAG_TEXT: TStringField;
    tblCarrNameUSDOTNUM: TStringField;
    tblCarrNameNAME: TStringField;
    tblCarrNameCITY: TStringField;
    tblCarrNameSTATE: TStringField;
    tblCarrNameNAME_TYPE_ID: TStringField;
    tblName2USDOTNUM: TStringField;
    tblName2NAME: TStringField;
    tblName2CITY: TStringField;
    tblName2STATE: TStringField;
    tblName2NAME_TYPE_ID: TStringField;
    tblHMPermitUSDOTNUM: TStringField;
    tblHMPermitPERMIT_TYPE: TStringField;
    tblHMPermitPERMIT_STATUS: TStringField;
    tblHMPermitEFFECTIVE_DATE: TDateField;
    tblHMPermitEXPIRATION_DATE: TDateField;
    tblHMPermitOPERATING_UNDER_APPEAL: TStringField;
    tblCarrInsUSDOTNUM: TStringField;
    tblCarrInsLIABILITY_STATUS: TStringField;
    tblCarrInsLIABILITY_REQUIRED: TFloatField;
    tblCarrInsCARGO_STATUS: TStringField;
    tblCarrInsBOND_STATUS: TStringField;
    tblCarrInsMEX_TERRITORY: TStringField;
    tblDataDateDATABASEDATE: TStringField;
    tblBasicsDetail: TUniTable;
    tblBasicsDetailUCR_SEQ_NUM: TIntegerField;
    tblBasicsDetailUSDOTNUM: TStringField;
    tblBasicsDetailBASE_STATE: TStringField;
    tblBasicsDetailPAYMENT_FLAG: TStringField;
    tblBasicsDetailREGISTRATION_YEAR: TStringField;
    tblBasicsDetailPAYMENT_DATE: TDateField;
    tblBasicsDetailINTRASTATE_VEHICLES: TStringField;
    tblBasicsDetailINTRA_VEH_TEXT: TStringField;
    tblBasicsDetailPAY_FLAG_TEXT: TStringField;
    procedure tblCarriersCalcFields(DataSet: TDataSet);
    procedure tblUCRCalcFields(DataSet: TDataSet);
    procedure tblISSCalcFields(DataSet: TDataSet);
    procedure tblUpdateStatusCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetCountryDesc(const CountryCode: string): string;
    function RebuildIdx: Boolean;
    procedure EmptyDatabase(tblname: string);
  end;

var
  dmISS_SQLite: TdmISS_SQLite;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dataModSAFER;

{$R *.dfm}

procedure TdmISS_SQLite.tblCarriersCalcFields(DataSet: TDataSet);
begin
  TblCarriersCountryCalc.AsString := GetCountryDesc(tblCarriers.FieldByName('COUNTRY').AsString);
end;

procedure TdmISS_SQLite.tblISSCalcFields(DataSet: TDataSet);
begin
  if (dmSAFER.qryIss.FieldByName('VEHICLE_INSPECTIONS_LAST30').AsInteger = 0) then
    tblIssVehicleOOSRate.AsInteger := dmSAFER.qryIss.FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsInteger
  else
    tblIssVehicleOOSRate.AsFloat := dmSAFER.qryIss.FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsInteger / dmSAFER.qryIss.FieldByName('VEHICLE_INSPECTIONS_LAST30').AsInteger;

  if (tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger = 0) then
    tblIssDriverOOSRate.Value := tblIss.FieldByName('OOS_DRIVER').AsFloat
  else
    tblIssDriverOOSRate.Value := tblIss.FieldByName('OOS_DRIVER').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsFloat;

  tblIssVehicleOOSPercent.Value := tblIssVehicleOOSRate.AsFloat * 100;
  tblIssDriverOOSPercent.Value := tblIssDriverOOSRate.AsFLoat * 100;

  if (tblCarriers.FieldByName('TOTAL_VEHICLES').AsInteger = 0) then
    tblIssInspPerVehicle.Value := tblIss.FieldByName('VEHICLE_INSPECTIONS').AsFloat
  else
    tblIssInspPerVehicle.Value := tblIss.FieldByName('VEHICLE_INSPECTIONS').AsFloat / tblCarriers.FieldByName('TOTAL_VEHICLES').AsFloat;

  if (tblCarriers.FieldByName('TOTAL_DRIVERS').AsInteger = 0) then
    tblIssInspPerDriver.Value := tblIss.FieldByName('DRIVER_INSPECTIONS').AsFloat
  else
    tblIssInspPerDriver.Value := tblIss.FieldByName('DRIVER_INSPECTIONS').AsFloat / tblCarriers.FieldByName('TOTAL_DRIVERS').AsFloat;

  if (tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger = 0) then begin
    tblISSv1BrakesRate.AsFloat := tblIss.FieldByName('VIOL_BRAKES').AsFloat;
    tblIssv1WheelRate.AsFloat := tblIss.FieldByName('VIOL_WHEELS').AsFloat;
    tblIssv1SteerRate.AsFloat := tblIss.FieldByName('Viol_STEERING').AsFloat;
    end
  else begin
    tblISSv1BrakesRate.AsFloat := tblIss.FieldByName('VIOL_BRAKES').AsFloat / tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger;
    tblIssv1WheelRate.AsFloat := tblIss.FieldByName('VIOL_WHEELS').AsFloat / tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger;
    tblIssv1SteerRate.AsFloat := tblIss.FieldByName('VIOL_STEERING').AsFloat / tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger;
  end;

  if (tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger = 0) then begin
    tblIssv1MedicalRate.AsFloat := tblIss.FieldByName('VIOL_MEDICAL').AsFloat;
    tblIssv1LogsRate.AsFloat    := tblIss.FieldByName('VIOL_LOGS').AsFloat;
    tblIssv1HoursRate.AsFloat   := tblIss.FieldByName('VIOL_HOURS').AsFloat;
    tblIssv1DQRate.AsFloat      := tblIss.FieldByName('VIOL_DISQUAL').AsFloat;
    tblIssv1DrugsRate.AsFloat   := tblIss.FieldByName('VIOL_DRUGS').AsFloat;
    tblIssv1TrafficRate.AsFloat := tblIss.FieldByName('VIOL_TRAFFIC').AsFloat;
    end
  else begin
    tblIssv1MedicalRate.AsFloat := tblIss.FieldByName('VIOL_MEDICAL').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1LogsRate.AsFloat    := tblIss.FieldByName('VIOL_LOGS').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1HoursRate.AsFloat   := tblIss.FieldByName('VIOL_HOURS').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1DQRate.AsFloat      := tblIss.FieldByName('VIOL_DISQUAL').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1DrugsRate.AsFloat   := tblIss.FieldByName('VIOL_DRUGS').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1TrafficRate.AsFloat := tblIss.FieldByName('VIOL_TRAFFIC').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
  end;

  if (tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger = 0) then begin
    tblIssv1HMPaperRate.asFloat := tblIss.FieldByName('VIOL_HMPAPER').AsFloat;
    tblIssv1HMPlacRate.AsFloat  := tblIss.FieldByName('VIOL_HMPLAC').AsFloat;
    tblIssv1HMOperRate.AsFloat  := tblIss.FieldByName('VIOL_HMOPER').AsFloat;
    tblIssv1HMTankRate.AsFloat  := tblIss.FieldByName('VIOL_HMTANK').AsFloat;
    tblIssv1HMOthrRate.AsFloat  := tblIss.FieldByName('VIOL_HMOTHR').AsFloat;
    end
  else begin
    tblIssv1HMPaperRate.AsFloat := tblIss.FieldByName('VIOL_HMPAPER').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMPlacRate.AsFloat  := tblIss.FieldByName('VIOL_HMPLAC').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMOperRate.AsFloat  := tblIss.FieldByName('VIOL_HMOPER').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMTankRate.AsFloat  := tblIss.FieldByName('VIOL_HMTANK').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMOthrRate.AsFloat  := tblIss.FieldByName('VIOL_HMOTHR').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
  end;
end;

procedure TdmISS_SQLite.tblUCRCalcFields(DataSet: TDataSet);
begin
  if tblUCR.FieldByName('PAYMENT_FLAG').AsString = 'Y' then
    tblUCRPAY_FLAG_TEXT.AsString := 'YES'
  else if tblUCR.FieldByName('PAYMENT_FLAG').AsString = 'N' then
    tblUCRPAY_FLAG_TEXT.AsString := 'NO';

  if tblUCR.FieldByName('INTRASTATE_VEHICLES').AsString = 'Y' then
    tblUCRINTRA_VEH_TEXT.AsString := 'YES'
  else if tblUCR.FieldByName('INTRASTATE_VEHICLES').AsString = 'N' then
    tblUCRINTRA_VEH_TEXT.AsString := 'NO';
end;

{-----------------------------------------------------------------------------
  Function:  GetCountryDesc
  Author:    J. L. Vasser, FMCSA
  Date:      2017-08-05
  Arguments: const CountryCode: string
  Return:    string
  Comments:  Translates SAFER's strange country codes to the country name
-----------------------------------------------------------------------------}
function TdmISS_SQLite.GetCountryDesc(const CountryCode: string): string;
begin
  case IndexStr('CountryCode',['A','C','M','P','S']) of
    0 : Result := 'UNITED STATES';
    1 : Result := 'CANADA';
    2 : Result := 'MEXICO';
    3 : Result := 'UNITED STATES'; // Puerto Rico // Don't know why its separate
    4 : Result := 'Central America';
  else
    Result := CountryCode;
  end;
end;

procedure TdmISS_SQLite.tblUpdateStatusCalcFields(DataSet: TDataSet);
begin
  case tblUpdateStatus.FieldByName('UpdtStatus').asInteger of
    0 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Not Begun';
    1 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Pending';
    2 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Complete';
  end;
end;

function TdmISS_SQLite.RebuildIdx: Boolean;
begin
  Result := False;
  try
    Result := True;
  except on E: Exception do
    ShowMessage('Reactivating and rebuilding Indexes Failed:'+#13#10+E.Message);
  end;
end;

procedure TdmISS_SQLite.EmptyDatabase(tblname: string);
begin
  with dbISS_LOCAL do begin
    if inTransaction then
      Rollback;
    StartTransaction;
    with sqlDelete do begin
      SQL.Clear;
      SQL.Text := 'delete from ' + tblname;
      Execute;
      end;
    try
      Commit;
    except on E: Exception do
      Rollback;
    end;
  end;
end;

end.
