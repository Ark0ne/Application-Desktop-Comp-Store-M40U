unit search_date;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFormSearchDate = class(TForm)
    grpDate: TGroupBox;
    grp1: TGroupBox;
    grp2: TGroupBox;
    dtpByDate: TDateTimePicker;
    dtpByPeriod: TDateTimePicker;
    dtpByPeriode2: TDateTimePicker;
    lbl1: TLabel;
    btnOk: TButton;
    btnOk2: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnOk2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSearchDate: TFormSearchDate;

implementation

uses
  datamodul, kategori, barang, penjualan;

{$R *.dfm}

procedure TFormSearchDate.FormShow(Sender: TObject);
begin
  dtpByDate.DateTime:=Now;
  dtpByPeriod.DateTime:=Now;
  dtpByPeriode2.DateTime:=Now;
end;

procedure TFormSearchDate.btnOkClick(Sender: TObject);
begin
  //form barang
  try
    with DM.zBarang do
      begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from barang where tgl_brg = "'+FormatDateTime('YYYY-MM-DD',dtpByDate.DateTime)+'"');
          Open;
      end;
      FormBarang.setCancel;
      FormBarang.dtpMasuk.DateTime:= FormSearchDate.dtpByDate.DateTime;
      Hide;
    except
      ShowMessage('Gagal Mencari Data');
  end;
  //form kategori
  try
    with DM.zKategori do
      begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from kategori where tgl_kat = "'+FormatDateTime('YYYY-MM-DD',dtpByDate.DateTime)+'"');
          Open;
      end;
      FormKategori.setCancel;
      FormKategori.dtpDate.DateTime:= FormSearchDate.dtpByDate.DateTime;
      Hide;
    except
      ShowMessage('Gagal Mencari Data');
  end;
  //form penjualan
  try
    with DM.zPenjualan do
      begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from penjualan where tgl_pjl = "'+FormatDateTime('YYYY-MM-DD',dtpByDate.DateTime)+'"');
          Open;
      end;
      FormPenjualan.setCancel;
      FormPenjualan.dtpPbl.DateTime:= FormSearchDate.dtpByDate.DateTime;
      FormSearchDate.Hide;
    except
      ShowMessage('Gagal Mencari Data');
  end;
end;

procedure TFormSearchDate.btnOk2Click(Sender: TObject);
begin
  //form barang
  try
    with DM.zBarang do
      begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from barang where tgl_brg between "'+FormatDateTime('YYYY-MM-DD',dtpByPeriod.DateTime)+'" AND "'+FormatDateTime('YYYY-MM-DD',dtpByPeriode2.DateTime)+'"' );
          Open;
      end;
      FormBarang.setCancel;
      FormBarang.dtpMasuk.DateTime:= FormSearchDate.dtpByPeriod.DateTime;
      Hide;
    except
      ShowMessage('Gagal Mencari Data');
  end;
  //form kategori
  try
    with DM.zKategori do
      begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from kategori where tgl_kat between "'+FormatDateTime('YYYY-MM-DD',dtpByPeriod.DateTime)+'" AND "'+FormatDateTime('YYYY-MM-DD',dtpByPeriode2.DateTime)+'"' );
          Open;
      end;
      FormKategori.setCancel;
      FormKategori.dtpDate.DateTime:= FormSearchDate.dtpByPeriod.DateTime;
      Hide;
    except
      ShowMessage('Gagal Mencari Data');
  end;
  //form penjualan
  try
    with DM.zPenjualan do
      begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from penjualan where tgl_pjl between "'+FormatDateTime('YYYY-MM-DD',dtpByPeriod.DateTime)+'" AND "'+FormatDateTime('YYYY-MM-DD',dtpByPeriode2.DateTime)+'"' );
          Open;
      end;
      FormPenjualan.setCancel;
      FormPenjualan.dtpPbl.DateTime:= FormSearchDate.dtpByPeriod.DateTime;
      Hide;
    except
      ShowMessage('Gagal Mencari Data');
  end;
end;

end.
