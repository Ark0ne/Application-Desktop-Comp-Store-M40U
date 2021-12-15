unit Lap_User;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet;

type
  TFormLap_User = class(TForm)
    frxdbdtst1: TfrxDBDataset;
    frxrprt1: TfrxReport;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLap_User: TFormLap_User;

implementation

uses
  menu, datamodul;

{$R *.dfm}

procedure TFormLap_User.FormShow(Sender: TObject);
begin
frxrprt1.ShowReport();
end;

end.
