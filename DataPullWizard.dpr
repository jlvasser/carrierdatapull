program DataPullWizard;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  formWizard in 'formWizard.pas' {frmMain},
  dataModISS_Firebird in 'dataModISS_Firebird.pas' {dmISS_FB: TDataModule},
  dataModISS_SQLite in 'dataModISS_SQLite.pas' {dmISS_SQLite: TDataModule},
  dataModReference in 'dataModReference.pas' {dmReference: TDataModule},
  dataModSAFER in 'dataModSAFER.pas' {dmSAFER: TDataModule},
  dialogEnvironment in 'dialogEnvironment.pas' {dlgDBEnvironment},
  dialogZipProgress in 'dialogZipProgress.pas' {dlgZipStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Carrier Data Pull Wizard';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmISS_FB, dmISS_FB);
  Application.CreateForm(TdmISS_SQLite, dmISS_SQLite);
  Application.CreateForm(TdmReference, dmReference);
  Application.CreateForm(TdmSAFER, dmSAFER);
  Application.CreateForm(TdlgDBEnvironment, dlgDBEnvironment);
  Application.CreateForm(TdlgZipStatus, dlgZipStatus);
  Application.Run;
end.
