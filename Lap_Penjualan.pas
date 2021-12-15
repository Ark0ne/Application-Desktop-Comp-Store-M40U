unit Lap_Penjualan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet;

type
  TFormLap_Penjualan = class(TForm)
    frxrprt1: TfrxReport;
    frxdbdtst1: TfrxDBDataset;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLap_Penjualan: TFormLap_Penjualan;

implementation

uses
  menu, datamodul;

{$R *.dfm}

procedure TFormLap_Penjualan.FormShow(Sender: TObject);
begin
  frxrprt1.ShowReport();
end;

end.
