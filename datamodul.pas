unit datamodul;

interface

uses
  SysUtils, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Menus, PrnDbgeh,Dialogs,Messages,
  Windows, Variants, Graphics, Controls, Forms,
  StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, ComCtrls, StrUtils,
  Mask, DBCtrlsEh, DBGridEhGrouping, GridsEh, DBGridEh, frxClass, frxDBSet;


type
  TDM = class(TDataModule)
    zcon: TZConnection;
    zAdmin: TZQuery;
    zKategori: TZQuery;
    zSuplier: TZQuery;
    zPenjualan: TZQuery;
    dsAdmin: TDataSource;
    dsBarang: TDataSource;
    dsKategori: TDataSource;
    dsSuplier: TDataSource;
    dsPenjualan: TDataSource;
    dtfldKategoritgl_kat: TDateField;
    strngfldKategorikd_kat: TStringField;
    strngfldKategorinm_kat: TStringField;
    prntdbKat: TPrintDBGridEh;
    pm1: TPopupMenu;
    mniHapus1: TMenuItem;
    mniCetak1: TMenuItem;
    prntdbSuplier: TPrintDBGridEh;
    zBarang: TZQuery;
    prntdbBrg: TPrintDBGridEh;
    prntdbPjl: TPrintDBGridEh;
    prntdbUser: TPrintDBGridEh;
    tmr1: TTimer;
    tmr3: TTimer;
    tmr4: TTimer;
    tmr2: TTimer;
    NotaPenjualan: TfrxReport;
    tmr5: TTimer;
    tmr6: TTimer;

    procedure mniCetak1Click(Sender: TObject);
    procedure mniHapus1Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
    procedure tmr3Timer(Sender: TObject);
    procedure tmr4Timer(Sender: TObject);
    procedure tmr5Timer(Sender: TObject);
    procedure tmr6Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses
  kategori, suplier, barang, kontroluser, penjualan, menu;

{$R *.dfm}



procedure TDM.mniCetak1Click(Sender: TObject);
begin
  if FormUser.Active = True then
    begin
      prntdbUser.Preview;
    end
  else if FormBarang.Active = True then
    begin
      prntdbBrg.Preview;
    end
  else if FormKategori.Active = True then
    begin
      prntdbKat.Preview;
    end
  else if FormSuplier.Active = True then
    begin
      prntdbSuplier.Preview;
    end
  else if FormPenjualan.Active = True then
    begin
      prntdbPjl.Preview;
    end;
end;

procedure TDM.mniHapus1Click(Sender: TObject);
begin
  if FormUser.Active = True then
  begin
  if FormUser.dbgrdUser.SelectedRows.Count= 0 then
  begin
    MessageDlg('Silahkan CheckList Data',mtWarning,[mbOK],0);
    Exit;
  end;
  if MessageDlg('[Yakin Ingin Meghapus Data Yang Dipilih]',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
    FormUser.dbgrdUser.SelectedRows.Delete;
  end
  else if FormBarang.Active = True then
  begin
  if FormBarang.dbgrdBrg.SelectedRows.Count= 0 then
  begin
    MessageDlg('Silahkan CheckList Data',mtWarning,[mbOK],0);
    Exit;
  end;
  if MessageDlg('[Yakin Ingin Meghapus Data Yang Dipilih]',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
    FormBarang.dbgrdBrg.SelectedRows.Delete;
  end
  else if FormKategori.Active = True then
  begin
  if FormKategori.dbgrdKat.SelectedRows.Count= 0 then
  begin
    MessageDlg('Silahkan CheckList Data',mtWarning,[mbOK],0);
    Exit;
  end;
  if MessageDlg('[Yakin Ingin Meghapus Data Yang Dipilih]',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
    FormKategori.dbgrdKat.SelectedRows.Delete;
  end
  else if FormSuplier.Active = True then
  begin
  if FormSuplier.dbgrdSuplier.SelectedRows.Count= 0 then
  begin
    MessageDlg('Silahkan Checklis Data',mtWarning,[mbOK],0);
    Exit;
  end;
  if MessageDlg('[Yakin Ingin Meghapus Data Yang Dipilih]',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
    FormSuplier.dbgrdSuplier.SelectedRows.Delete;
  end
  else if FormPenjualan.Active = True then
  begin
  if FormPenjualan.dbgrdPjl.SelectedRows.Count= 0 then
  begin
    MessageDlg('Silahkan CheckList Data',mtWarning,[mbOK],0);
    Exit;
  end;
  if MessageDlg('[Yakin Ingin Meghapus Data Yang Dipilih]',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
    FormPenjualan.dbgrdPjl.SelectedRows.Delete;
  end;
end;

procedure TDM.tmr1Timer(Sender: TObject);
begin
   FormMenu.img1.visible:=True;
   FormMenu.img2.visible:=False;
   FormMenu.img3.Visible:=False;
   FormMenu.img4.Visible:=False;
   FormMenu.img5.Visible:=False;
   FormMenu.img6.Visible:=False;

   tmr1.Enabled:=False;
   tmr2.Enabled:=True;
   tmr3.Enabled:=false;
   tmr4.Enabled:=False;
   tmr5.Enabled:=False;
   tmr6.Enabled:=False;
end;

procedure TDM.tmr2Timer(Sender: TObject);
begin
  FormMenu.img1.visible:=False;
   FormMenu.img2.visible:=True;
   FormMenu.img3.Visible:=False;
   FormMenu.img4.Visible:=False;
   FormMenu.img5.Visible:=False;
   FormMenu.img6.Visible:=False;

   tmr1.Enabled:=False;
   tmr2.Enabled:=False;
   tmr3.Enabled:=True;
   tmr4.Enabled:=False;
   tmr5.Enabled:=False;
   tmr6.Enabled:=False;
end;

procedure TDM.tmr3Timer(Sender: TObject);
begin
   FormMenu.img1.visible:=False;
   FormMenu.img2.visible:=False;
   FormMenu.img3.Visible:=True;
   FormMenu.img4.Visible:=False;
   FormMenu.img5.Visible:=False;
   FormMenu.img6.Visible:=False;

   tmr1.Enabled:=False;
   tmr2.Enabled:=False;
   tmr3.Enabled:=False;
   tmr4.Enabled:=True;
   tmr5.Enabled:=False;
   tmr6.Enabled:=False;
end;

procedure TDM.tmr4Timer(Sender: TObject);
begin
   FormMenu.img1.visible:=False;
   FormMenu.img2.visible:=False;
   FormMenu.img3.Visible:=False;
   FormMenu.img4.Visible:=True;
   FormMenu.img5.Visible:=False;
   FormMenu.img6.Visible:=False;

   tmr1.Enabled:=False;
   tmr2.Enabled:=False;
   tmr3.Enabled:=false;
   tmr4.Enabled:=False;
   tmr5.Enabled:=True;
   tmr6.Enabled:=False;
end;

procedure TDM.tmr5Timer(Sender: TObject);
begin
   FormMenu.img1.visible:=False;
   FormMenu.img2.visible:=False;
   FormMenu.img3.Visible:=False;
   FormMenu.img4.Visible:=False;
   FormMenu.img5.Visible:=True;
   FormMenu.img6.Visible:=False;

   tmr1.Enabled:=False;
   tmr2.Enabled:=False;
   tmr3.Enabled:=false;
   tmr4.Enabled:=False;
   tmr5.Enabled:=False;
   tmr6.Enabled:=True;
end;

procedure TDM.tmr6Timer(Sender: TObject);
begin
   FormMenu.img1.visible:=False;
   FormMenu.img2.visible:=False;
   FormMenu.img3.Visible:=False;
   FormMenu.img4.Visible:=False;
   FormMenu.img5.Visible:=False;
   FormMenu.img6.Visible:=True;

   tmr1.Enabled:=True;
   tmr2.Enabled:=False;
   tmr3.Enabled:=false;
   tmr4.Enabled:=False;
   tmr5.Enabled:=False;
   tmr6.Enabled:=False;
end;

end.
