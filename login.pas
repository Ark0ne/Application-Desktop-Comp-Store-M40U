unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, Mask, RzEdit, ExtCtrls, RzPanel, RzLabel,
  RzButton;

type
  TFormLogin = class(TForm)
    panel1: TRzPanel;
    edtUserName: TRzEdit;
    edtPw: TRzEdit;
    cbbBagian: TRzComboBox;
    btnLogin: TRzButton;
    btnCancel: TRzButton;
    btnExit: TRzButton;
    lblName: TRzLabel;
    lblPw: TRzLabel;
    lblBagian: TRzLabel;
    chkPw: TCheckBox;
    procedure btnLoginClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure seleksiLogin;
    procedure setCancel;
    procedure setShow;
    procedure FormShow(Sender: TObject);
    procedure chkPwClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

uses menu, datamodul;

{$R *.dfm}

procedure tformlogin.setCancel;
begin
  edtUserName.Text:= '';
  edtPw.Text:= '';
  cbbBagian.Text:= '';
end;

procedure TFormLogin.setShow;
begin
  if chkPw.Checked then
  begin
    edtPw.PasswordChar:= #0;
  end
  else if chkPw.Checked = False then
  begin
    edtPw.PasswordChar:= '*';
  end;
end;

procedure TFormLogin.seleksiLogin;
begin
   if DM.zAdmin.FieldByName('divisi').AsString = LowerCase('master') then
    begin
      FormMenu.Kontrol.Enabled := true;
      FormMenu.Login.Enabled := False;
      FormMenu.Logout.Enabled := True;
      FormMenu.KontrolUser.Enabled := True;
      FormMenu.Exit.Enabled := True;
      FormMenu.Gudang.Enabled := True;
      FormMenu.DataBarang.Enabled := True;
      FormMenu.KategoriBarang.Enabled := True;
      FormMenu.Suplier.Enabled := True;
      FormMenu.Kasir.Enabled := True;
      FormMenu.Penjualan.Enabled := True;
      FormMenu.Laporan.Enabled := True;
      FormMenu.Lap_User.Enabled := True;
      FormMenu.Lap_Barang.Enabled := True;
      FormMenu.Lap_Penjualan.Enabled := True;
      FormMenu.Show;
      setCancel;
      hide;
    end
   else if DM.zAdmin.FieldByName('divisi').AsString = LowerCase('kasir') then
    begin
      FormMenu.Kontrol.Enabled := true;
      FormMenu.Login.Enabled := False;
      FormMenu.Logout.Enabled := True;
      FormMenu.KontrolUser.Enabled := False;
      FormMenu.Exit.Enabled := True;
      FormMenu.Gudang.Enabled := False;
      FormMenu.DataBarang.Enabled := False;
      FormMenu.KategoriBarang.Enabled := False;
      FormMenu.Suplier.Enabled := False;
      FormMenu.Kasir.Enabled := True;
      FormMenu.Penjualan.Enabled := True;
      FormMenu.Laporan.Enabled := True;
      FormMenu.Lap_User.Enabled := False;
      FormMenu.Lap_Barang.Enabled := False;
      FormMenu.Lap_Penjualan.Enabled := True;
      FormMenu.Show;
      setCancel;
      hide;
    end
   else if DM.zAdmin.FieldByName('divisi').AsString = LowerCase('gudang') then
    begin
      FormMenu.Kontrol.Enabled := True;
      FormMenu.Login.Enabled := False;
      FormMenu.Logout.Enabled := True;
      FormMenu.KontrolUser.Enabled := False;
      FormMenu.Exit.Enabled := True;
      FormMenu.Gudang.Enabled := True;
      FormMenu.DataBarang.Enabled := True;
      FormMenu.KategoriBarang.Enabled := True;
      FormMenu.Suplier.Enabled := True;
      FormMenu.Kasir.Enabled := False;
      FormMenu.Penjualan.Enabled := False;
      FormMenu.Laporan.Enabled := True;
      FormMenu.Lap_User.Enabled := False;
      FormMenu.Lap_Barang.Enabled := True;
      FormMenu.Lap_Penjualan.Enabled := False;
      FormMenu.Show;
      setCancel;
      hide;
    end;

end;

procedure TFormLogin.btnLoginClick(Sender: TObject);
begin
  if edtUserName.Text = '' then
    Application.MessageBox('UserName kosong','Information',MB_OK or MB_ICONINFORMATION)
  else if edtPw.Text = '' then
   Application.MessageBox('Password kosong','Information',MB_OK or MB_ICONINFORMATION)
  else if cbbBagian.Items.Text = '' then
   Application.MessageBox('Bagian kosong','Information',MB_OK or MB_ICONINFORMATION)
  else
   begin
  try
    begin
      with DM.zAdmin do
      begin
        Active:=False;
        SQL.Clear;
        Close;
        SQL.Add('select * from admin where u_name = '+QuotedStr(edtUserName.Text));
        Open;
      end;
        if DM.zAdmin.RecordCount = 0 then
          Application.MessageBox('UserName tidak ditemukan','Information',MB_OK or MB_ICONINFORMATION)
        else
          begin
            if DM.zAdmin.FieldByName('u_pass').AsString <> edtPw.Text then
              begin
                Application.MessageBox('Password tidak cocok','Information',MB_OK or MB_ICONINFORMATION)
              end
            else
            begin
              if DM.zAdmin.FieldByName('divisi').AsString <> LowerCase(cbbBagian.Text) then
                begin
                  Application.MessageBox('Bagian tidak cocok','Information',MB_OK or MB_ICONINFORMATION)
                end
              else
                begin
                   seleksiLogin;
                    setCancel;
                end;
            end;

          end;

    end;
    Except
     ShowMessage('UserName, Password, dan Bagian tidak cocok');
     edtUserName.SetFocus;

end;
end;

end;


procedure TFormLogin.btnExitClick(Sender: TObject);
begin
  if MessageDlg ('Apkah anda benar ingin menutup aplikasi', mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
  Application.Terminate;
end;

procedure TFormLogin.btnCancelClick(Sender: TObject);
begin
  setCancel;
end;

procedure TFormLogin.FormShow(Sender: TObject);
begin
  setCancel;
end;

procedure TFormLogin.chkPwClick(Sender: TObject);
begin
  setShow;
end;

procedure TFormLogin.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if MessageDlg ('Benar ingin menutup aplikasi', mtConfirmation, [mbYes]+ [mbNo], 0) = mrno then
  CanClose:= False;
end;

end.
