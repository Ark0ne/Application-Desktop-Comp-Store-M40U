unit kontroluser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,StrUtils,
  DBGridEhGrouping, GridsEh, DBGridEh;

type
  TFormUser = class(TForm)
    pnl1: TPanel;
    lblUserName: TLabel;
    lblPw: TLabel;
    lblDivisi: TLabel;
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtIdUser: TEdit;
    lblIdUser: TLabel;
    cbbDivisi: TComboBox;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnUbah: TBitBtn;
    btnCari: TBitBtn;
    btnKeluar: TBitBtn;
    lblTittle: TLabel;
    rbkd: TRadioButton;
    rbNama: TRadioButton;
    dbgrdUser: TDBGridEh;
    btnBatal: TBitBtn;
    procedure autoGenerate;
    procedure loadData;
    procedure search;
    procedure setCancel;
    procedure setMsgIsEmpty;
    procedure btnCariClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnUbahClick(Sender: TObject);
    procedure btnKeluarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnBatalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrdUserCellClick(Column: TColumnEh);
    procedure cbbDivisiKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUser: TFormUser;

implementation

uses
  datamodul, menu;

{$R *.dfm}

procedure TFormUser.autoGenerate;
var
  left,phrase : string;
begin
  left := LeftStr(edtUsername.Text,4);
  phrase := LeftStr(cbbDivisi.Text,3);
  edtIdUser.Text := FormatDateTime('dd-yy',Now) + FormatDateTime('-HH-MM-SS',Now) + left +  phrase;
end;

procedure TFormUser.loadData;
begin
  try
    with DM.zAdmin do
    begin
    Close;
    SQL.Clear;
    SQL.Add('select * from admin');
    Open;
    end;
    except
      ShowMessage('Gagal Refresh Data');
  end;
end;

procedure TFormUser.setCancel;
begin
   edtUsername.Text :='';
   edtIdUser.Text :='';
   edtPassword.Text :='';
   cbbDivisi.Text :='';
   rbkd.Checked:=False;
   rbNama.Checked:=False;
   btnHapus.Enabled:=False;
   btnUbah.Enabled:=False;
end;

procedure TFormUser.setMsgIsEmpty;
begin
  if edtUsername.Text = '' then
    begin
    Application.MessageBox('UserName kosong','Warning',MB_OK or MB_ICONWARNING);
    edtUsername.SetFocus;
    end
  else if edtPassword.Text = '' then
    begin
    Application.MessageBox('Password kosong','Warning',MB_OK or MB_ICONWARNING);
    edtPassword.SetFocus;
    end
  else if cbbDivisi.Text = '' then
    begin
    Application.MessageBox('Pilih Index Bagian','Warning',MB_OK or MB_ICONWARNING);
    cbbDivisi.SetFocus;
    end;
end;

procedure TFormUser.search;
var
  msg : string;
begin
  if rbkd.Checked then
    begin
    msg := InputBox('Masukan Kode Id User','Field Kode Id User','');
    if msg <> '' then
      begin
        edtIdUser.Text := msg;
        with DM.zAdmin do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from admin where kd_admin like '+''''+'%'+edtIdUser.Text+'%'+'''');
          Open;
        end;
      end
      else
        setCancel;
  end
  else if rbNama.Checked then
  begin
    msg := InputBox('Masukan UserName','Field User Name','');
    if msg <> '' then
      begin
        edtUsername.Text := msg;
        with DM.zAdmin do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from admin where u_name LIKE '+''''+'%'+edtUserName.Text+'%'+'''');
          Open;
        end;
      end
      else
        setCancel;
  end
  else
  begin
    Application.MessageBox('Silahkan Checklist pencarian','Information',MB_OK or MB_ICONINFORMATION)
  end;

end;

procedure TFormUser.btnCariClick(Sender: TObject);
begin
  search;
  setCancel;
end;

procedure TFormUser.btnSimpanClick(Sender: TObject);
begin
  setMsgIsEmpty;
  if  (edtUsername.Text <> '') and (edtPassword.Text <> '') and (cbbDivisi.Text <> '') then
    begin
      autoGenerate;
      if MessageDlg('[Kode Id User : ' +edtIdUser.Text+ '][UserName : '+edtUsername.Text+'][Bagian : '+cbbDivisi.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
       try
        begin
          with  DM.zAdmin do
          begin
          Close;
          SQL.Clear;
          SQL.Add('insert into admin(kd_admin,u_name,u_pass,divisi)');
          SQL.Add('values(:kode,:nama,:pass,:divisi)');
          ParamByName('kode').AsString := edtIdUser.Text;
          ParamByName('nama').AsString := edtUsername.Text;
          ParamByName('pass').AsString := edtPassword.Text;
          ParamByName('divisi').AsString := LowerCase(cbbDivisi.Text);
          ExecSQL;
          SQL.Clear;
          loadData;
          Open;
          end;
          ShowMessage('Data Berhasil Disimpan');
          setCancel;
        end;
      except
        ShowMessage('Data Gagal Disimpan');
      end;

      end;
end;

procedure TFormUser.btnHapusClick(Sender: TObject);
begin
  if edtIdUser.Text <> '' then
  begin
  try
    if MessageDlg('Yakin ingin menghapus [Kode Id User : ' +edtIdUser.Text+ '][UserName : '+edtUsername.Text+'][Bagian : '+cbbDivisi.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        begin
          with  DM.zAdmin do
          begin
          Close;
          SQL.Clear;
          SQL.Add('delete from admin where kd_admin = "'+edtIdUser.Text+'"');
          ExecSQL;
          SQL.Clear;
          loadData;
          Open;
          end;
          ShowMessage('Data Berhasil Dihapus');
          setCancel;
        end;
  except
    ShowMessage('Gagal hapus data');
  end;
 end
 else
 begin
    Application.MessageBox('Kode Id User Tidak Terpilih','Information',MB_OK or MB_ICONINFORMATION)
  end

end;

procedure TFormUser.btnUbahClick(Sender: TObject);
begin
  setMsgIsEmpty;
  if  (edtUsername.Text <> '') and (edtPassword.Text <> '') and (cbbDivisi.Text <> '') then
    begin
      if MessageDlg('[Kode Id User : ' +edtIdUser.Text+ '][UserName : '+edtUsername.Text+'][Bagian : '+cbbDivisi.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        try
        begin
          with  DM.zAdmin do
          begin
          Close;
          SQL.Clear;
          SQL.Add('update admin set u_name=:nama,u_pass=:pass,divisi=:div where kd_admin =:kode');
          ParamByName('kode').AsString := edtIdUser.Text;
          ParamByName('nama').AsString := edtUsername.Text;
          ParamByName('pass').AsString := edtPassword.Text;
          ParamByName('div').AsString := LowerCase(cbbDivisi.Text);
          ExecSQL;
          SQL.Clear;
          loadData;
          Open;
          end;
          ShowMessage('Data Berhasil DiUbah');
          setCancel;
        end;
        except
         ShowMessage('Data Gagal Diubah');
    end;
      end;
end;

procedure TFormUser.btnKeluarClick(Sender: TObject);
begin
  formmenu.show;
  hide;
end;

procedure TFormUser.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= False;
end;

procedure TFormUser.FormShow(Sender: TObject);
begin
  setCancel;
  loadData;
end;

procedure TFormUser.btnBatalClick(Sender: TObject);
begin
  setCancel;
  loadData;
end;

procedure TFormUser.FormCreate(Sender: TObject);
begin
  setCancel;
end;

procedure TFormUser.dbgrdUserCellClick(Column: TColumnEh);
begin
  setCancel;
  btnHapus.Enabled:=True;
  btnUbah.Enabled:=True;
  try
    with DM.zAdmin do
    begin
    edtIdUser.Text:= Fields[0].AsString;
    edtUsername.Text:= Fields[1].AsString;
    cbbDivisi.Text:= Fields[3].AsString;
    edtPassword.Text:= DM.zAdmin.Fields[2].AsString;
    end;
  except
    ShowMessage('Tidak dapat mengambil nilai');
  end;
end;

procedure TFormUser.cbbDivisiKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in[#8,#13]) then
 begin
   key:=#0;
   showmessage('Pilih Index Bagian');
 end;
end;

end.
