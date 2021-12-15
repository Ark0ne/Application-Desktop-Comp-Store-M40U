unit menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, jpeg, ExtCtrls;

type
  TFormMenu = class(TForm)
    mm1: TMainMenu;
    Kontrol: TMenuItem;
    Login: TMenuItem;
    Logout: TMenuItem;
    KontrolUser: TMenuItem;
    Exit: TMenuItem;
    Gudang: TMenuItem;
    DataBarang: TMenuItem;
    KategoriBarang: TMenuItem;
    Suplier: TMenuItem;
    Kasir: TMenuItem;
    Laporan: TMenuItem;
    Lap_User: TMenuItem;
    Lap_Barang: TMenuItem;
    Lap_Penjualan: TMenuItem;
    Penjualan: TMenuItem;
    img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img5: TImage;
    img6: TImage;
    procedure logOutMM;
    procedure LogoutClick(Sender: TObject);
    procedure LoginClick(Sender: TObject);
    procedure KontrolUserClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure DataBarangClick(Sender: TObject);
    procedure KategoriBarangClick(Sender: TObject);
    procedure SuplierClick(Sender: TObject);
    procedure PenjualanClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Lap_BarangClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Lap_UserClick(Sender: TObject);
    procedure Lap_PenjualanClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenu: TFormMenu;

implementation

uses login, kontroluser, barang, kategori, suplier, penjualan, Lap_Barang,
  datamodul, Lap_User, Lap_Penjualan;

{$R *.dfm}

procedure TFormMenu.logOutMM;
begin
  FormMenu.Login.Enabled := False;
  FormMenu.Kontrol.Enabled := False;
  FormMenu.Gudang.Enabled := False;
  FormMenu.Kasir.Enabled := False;
  FormMenu.Laporan.Enabled := False;
end;


procedure TFormMenu.LogoutClick(Sender: TObject);
begin
  if messagedlg('Apkah yakin ingin Logout...?',mtconfirmation,[mbYes]+[mbNo],0)=mrYes
  then
  begin
     logOutMM;
     FormLogin.Show;
     FormLogin.edtUserName.SetFocus;
     hide;
 end;
end;

procedure TFormMenu.LoginClick(Sender: TObject);
begin
  logOutMM;
  FormLogin.Show;
  FormLogin.edtUserName.SetFocus;
  Hide;
end;

procedure TFormMenu.KontrolUserClick(Sender: TObject);
begin
 FormUser.Show;
 hide;
end;

procedure TFormMenu.ExitClick(Sender: TObject);
begin
  if MessageDlg ('Benar ingin menutup aplikasi', mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
  Application.Terminate;
end;

procedure TFormMenu.DataBarangClick(Sender: TObject);
begin
  FormBarang.Show;
  hide;
end;

procedure TFormMenu.KategoriBarangClick(Sender: TObject);
begin
  FormKategori.Show;
  hide;
end;

procedure TFormMenu.SuplierClick(Sender: TObject);
begin
  FormSuplier.Show;
  hide;
end;

procedure TFormMenu.PenjualanClick(Sender: TObject);
begin
  FormPenjualan.Show;
  hide;
end;

procedure TFormMenu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg ('Benar ingin menutup aplikasi', mtConfirmation, [mbYes]+ [mbNo], 0) = mrno then
  CanClose:= False;
end;

procedure TFormMenu.Lap_BarangClick(Sender: TObject);
begin
 formlap_barang.frxrprt1.ShowReport();
end;

procedure TFormMenu.FormCreate(Sender: TObject);
begin
logOutMM;
  FormMenu.Kontrol.Enabled:= True;
  FormMenu.Login.Enabled:= True;
  FormMenu.Logout.Enabled:=False;
  FormMenu.KontrolUser.Enabled:=False;
end;


procedure TFormMenu.FormShow(Sender: TObject);
begin
  DM.tmr1Timer(Sender);
end;

procedure TFormMenu.Lap_UserClick(Sender: TObject);
begin
 FormLap_User.frxrprt1.ShowReport();
end;

procedure TFormMenu.Lap_PenjualanClick(Sender: TObject);
begin
 FormLap_Penjualan.frxrprt1.ShowReport();
end;

end.
