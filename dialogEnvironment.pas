unit dialogEnvironment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, RzPanel, RzDlgBtn,
  RzRadGrp, Vcl.StdCtrls, RzLabel;

type
  TdlgDBEnvironment = class(TForm)
    btnBar: TRzDialogButtons;
    grpSelectEnv: TRzRadioGroup;
    lblSelected: TRzLabel;
    procedure grpSelectEnvClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgDBEnvironment: TdlgDBEnvironment;

implementation

{$R *.dfm}

procedure TdlgDBEnvironment.grpSelectEnvClick(Sender: TObject);
begin
  if grpSelectEnv.ItemIndex = 0 then
    lblSelected.Caption := 'safer.fmcsa.dot.gov'
  else
    lblSelected.Caption := '10.75.161.103';
end;

end.
