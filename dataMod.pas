{-----------------------------------------------------------------------------
 Unit Name: dataMod
 Author:    J. L. Vasser (FMCSA)
 Date:      2017-10-02
 Purpose:   Data Module for Data Pull.
            Provides the bridge between the SAFER Oracle-based database and
            the Firedbird-based Local Aspen / ISS database
 History:
             2018-02-05 JLV -
             Removed "where MCMIS_STATUS = 'A'" clause from all child table SAFER
             queries.  Due to the time lag involved after creating the parent
             table (CARRIERS), many records had become inactive.  This then
             caused the child record to not be found

             2018-02-07 JLV -
             Modifed query on UCR to limit the amount of (useless) data returned.
             See frmMain.DoUCRLoad function

             2018-02-20 JLV -
             Removed unused data objects and related code.

             2019-02-03 JLV -
             Added a data module for using SQLite database for the local database.
             This is much smaller and MUCH MUCH faster.
             Then moved the Firebird database to its own data module to allow
             keeping the database components the same.
-----------------------------------------------------------------------------}
unit dataMod;

interface

uses
  System.SysUtils, System.Classes, DALoader, UniLoader, Uni, Data.DB, MemDS,
  DBAccess, InterBaseUniProvider, UniProvider, OracleUniProvider, UniScript,
  CRBatchMove, DAScript, System.UITypes, Dialogs, Vcl.Forms, System.StrUtils,
  VirtualTable;

type
  TdmPull = class(TDataModule)
    providerSAFER: TOracleUniProvider;
    dbSAFER: TUniConnection;
    qryISS: TUniQuery;
    qryCarrier: TUniQuery;
    qryUCR: TUniQuery;
    qryNAME: TUniQuery;
    qryNAME2: TUniQuery;
    qryHMPermit: TUniQuery;
    qryINS: TUniQuery;
    qryBASICS: TUniQuery;
    qryNAMEUSDOTNUM: TStringField;
    qryNAMENAME: TStringField;
    qryNAMECITY: TStringField;
    qryNAMESTATE: TStringField;
    qryNAMENAME_TYPE_ID: TStringField;
    //procedure tblCarriersCalcFields(DataSet: TDataSet);
    //procedure tblUCRCalcFields(DataSet: TDataSet);
    //procedure tblISSCalcFields(DataSet: TDataSet);
    //procedure tblUpdateStatusCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    //function GetCountryDesc(const CountryCode: string): string;
    //function RebuildIdx: Boolean;
  end;

var
  dmPull: TdmPull;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses formMain;

{$R *.dfm}

{
procedure TdmPull.tblCarriersCalcFields(DataSet: TDataSet);
begin
  TblCarriersCountryCalc.AsString := GetCountryDesc(tblCarriers.FieldByName('COUNTRY').AsString);
end;

procedure TdmPull.tblISSCalcFields(DataSet: TDataSet);
begin
  if (qryIss.FieldByName('VEHICLE_INSPECTIONS_LAST30').AsInteger = 0) then
    tblIssVehicleOOSRate.AsInteger := qryIss.FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsInteger
  else
    tblIssVehicleOOSRate.AsFloat := qryIss.FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsInteger / qryIss.FieldByName('VEHICLE_INSPECTIONS_LAST30').AsInteger;

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

procedure TdmPull.tblUCRCalcFields(DataSet: TDataSet);
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
}

(*
{-----------------------------------------------------------------------------
  Function:  GetCountryDesc
  Author:    J. L. Vasser, FMCSA
  Date:      2017-08-05
  Arguments: const CountryCode: string
  Return:    string
  Comments:  Translates SAFER's strange country codes to the country name
-----------------------------------------------------------------------------}
function TdmPull.GetCountryDesc(const CountryCode: string): string;
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

procedure TdmPull.tblUpdateStatusCalcFields(DataSet: TDataSet);
begin
  case tblUpdateStatus.FieldByName('UpdtStatus').asInteger of
    0 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Not Begun';
    1 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Pending';
    2 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Complete';
  end;
end;

function TdmPull.RebuildIdx: Boolean;
begin
  Result := False;
  try
    Result := True;
  except on E: Exception do
    ShowMessage('Reactivating and rebuilding Indexes Failed:'+#13#10+E.Message);
  end;
end;

*)

end.
