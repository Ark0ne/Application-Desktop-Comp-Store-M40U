unit suplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,StrUtils,
  DBGridEhGrouping, GridsEh, DBGridEh;

type
  TFormSuplier = class(TForm)
    pnl1: TPanel;
    lblUserName: TLabel;
    lblPw: TLabel;
    lblDivisi: TLabel;
    lblIdUser: TLabel;
    edtNamaSp: TEdit;
    edtPT: TEdit;
    edtKdSp: TEdit;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnUbah: TBitBtn;
    btnCari: TBitBtn;
    btnKeluar: TBitBtn;
    edtAlamat: TEdit;
    edtKontak: TEdit;
    lbl7: TLabel;
    lblKontak: TLabel;
    dbgrdSuplier: TDBGridEh;
    rbPT: TRadioButton;
    rbNama: TRadioButton;
    rbKd: TRadioButton;
    btnBatal: TBitBtn;
    procedure autoGenerate;
    procedure setCancel;
    procedure setMsgisEmpty;
    procedure loadData;
    procedure search;
    procedure btnKeluarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbgrdSuplierCellClick(Column: TColumnEh);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCariClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnUbahClick(Sender: TObject);
    procedure edtKontakKeyPress(Sender: TObject; var Key: Char);
    procedure btnBatalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSuplier: TFormSuplier;

implementation

uses
  datamodul, menu;

{$R *.dfm}

procedure TFormSuplier.autoGenerate;
var
  lefts,rights : string;
begin
  lefts := UpperCase(LeftStr(edtNamaSp.Text,1));
  rights := UpperCase(RightStr(edtNamaSp.Text,3));
  edtKdSp.Text := 'S' + lefts + rights + FormatDateTime('ddmmyyss',Now);
end;

procedure TFormSuplier.setCancel;
begin
   edtKdSp.Text :='';
   edtNamaSp.Text :='';
   edtPT.Text:='';
   edtAlamat.Text:='';
   edtKontak.Text:='';
   rbKd.Checked:=False;
   rbNama.Checked:=false;
   rbPT.Checked:=False;
   btnHapus.Enabled:=False;
   btnUbah.Enabled:=False;
end;

procedure TFormSuplier.setMsgisEmpty;
begin
  if edtKdSp.Text = '' then
  begin
    Application.MessageBox('Kode Suplier Kosong','Warning',MB_OK or MB_ICONWARNING);
  end
  else if edtNamaSp.Text = '' then
  begin
    Application.MessageBox('Nama Suplier kosong','Warning',MB_OK or MB_ICONWARNING);
    edtNamaSp.SetFocus;
  end
  else if edtAlamat.Text = '' then
  begin
    Application.MessageBox('Alamat Suplier Tidak Boleh kosong','Warning',MB_OK or MB_ICONWARNING);
    edtAlamat.SetFocus;
  end;
end;

procedure TFormSuplier.loadData;
begin
   try
    with DM.zSuplier do
    begin
    Close;
    SQL.Clear;
    SQL.Add('select * from suplier');
    Open;
    end;
    except
      ShowMessage('Gagal Mengambil Data Dari Database');
  end;
end;

procedure TFormSuplier.search;
var
  msg : string;
begin
  if rbKd.Checked then
    begin
    msg := InputBox('Masukan Kode Suplier','Field Kode Suplier','');
    if msg <> '' then
      begin
        edtKdSp.Text := msg;
        with DM.zSuplier do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from suplier where kd_sp like '+''''+'%'+edtKdSp.Text+'%'+'''');
          Open;
        setCancel;
        edtKdSp.Text:=msg;
        end;
      end
      else
        setCancel
  end
  else if rbNama.Checked then
  begin
    msg := InputBox('Masukan Nama Suplier','Field Nama Suplier','');
    if msg <> '' then
      begin
        edtNamaSp.Text := msg;
        with DM.zSuplier do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from suplier where nama_sp LIKE '+''''+'%'+edtNamaSp.Text+'%'+'''');
          Open;
          setCancel;
          edtNamaSp.Text:=msg;
        end;
      end
      else
        setCancel;
  end
  else if rbPT.Checked then
  begin
     msg := InputBox('Masukan Nama Perusahaan Suplier','Field Nama Perusahaan Suplier','');
    if msg <> '' then
      begin
        edtPT.Text := msg;
        with DM.zSuplier do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from suplier where perusahaan_sp LIKE '+''''+'%'+edtPT.Text+'%'+'''');
          Open;
          setCancel;
          edtPT.Text:=msg;
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

procedure TFormSuplier.dbgrdSuplierCellClick(Column: TColumnEh);
begin
  btnHapus.Enabled:=True;
  btnUbah.Enabled:=True;
  try
    with DM.zSuplier do
    begin
    edtKdSp.Text:= Fields[0].AsString;
    edtNamaSp.Text:= Fields[1].AsString;
    edtPT.Text:= Fields[2].AsString;
    edtKontak.Text:= Fields[4].AsString;
    edtAlamat.Text:= Fields[3].AsString;
    end;
  except
    ShowMessage('Tidak dapat mengambil nilai');
  end;
end;

procedure TFormSuplier.FormCreate(Sender: TObject);
begin
  setCancel;
end;

procedure TFormSuplier.FormShow(Sender: TObject);
begin
  setCancel;
  loadData;
end;

procedure TFormSuplier.btnCancelClick(Sender: TObject);
begin
  setCancel;
  loadData;
end;

procedure TFormSuplier.btnCariClick(Sender: TObject);
begin
  search;
end;

procedure TFormSuplier.btnKeluarClick(Sender: TObject);
begin
  formmenu.show;
  hide;
end;

procedure TFormSuplier.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   CanClose:= False;
end;

procedure TFormSuplier.btnSimpanClick(Sender: TObject);
begin
  autoGenerate;
  setMsgisEmpty;
  if ((edtKdSp.Text <> '') and (edtNamaSp.Text <> '') and (edtAlamat.Text <> '')) then
  begin
      if MessageDlg('[Kode Suplier : ' +edtKdSp.Text+ '][Nama Suplier : '+edtNamaSp.Text+'][Alamat : '+edtAlamat.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
       try
        begin
          with  DM.zSuplier do
          begin
          Close;
          SQL.Clear;
          SQL.Add('insert into suplier(kd_sp,nama_sp,perusahaan_sp,alamat_sp,kontak_sp)');
          SQL.Add('values(:kode,:nama,:pt,:alamat,:kontak)');
          ParamByName('kode').AsString := edtKdSp.Text;
          ParamByName('nama').AsString := edtNamaSp.Text;
          ParamByName('pt').AsString:=  edtPT.Text;
          ParamByName('alamat').AsString:=  edtAlamat.Text;
          ParamByName('kontak').AsString:=  edtKontak.Text;
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

procedure TFormSuplier.btnHapusClick(Sender: TObject);
begin
  if edtKdSp.Text <> '' then
  begin
  try
    if MessageDlg('[Kode Suplier : ' +edtKdSp.Text+ '][Nama Suplier : '+edtNamaSp.Text+'][Alamat : '+edtAlamat.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        begin
          with  DM.zSuplier do
          begin
          Close;
          SQL.Clear;
          SQL.Add('delete from suplier where kd_sp = "'+edtKdSp.Text+'"');
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
    Application.MessageBox('Kode Suplier Tidak Terpilih','Information',MB_OK or MB_ICONINFORMATION)
  end
end;

procedure TFormSuplier.btnUbahClick(Sender: TObject);
begin
  setMsgisEmpty;
    if MessageDlg('[Kode Suplier : ' +edtKdSp.Text+ '][Nama Suplier : '+edtNamaSp.Text+'][Alamat : '+edtAlamat.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        try
        begin
          with  DM.zSuplier do
          begin
          Close;
          SQL.Clear;
          SQL.Add('update suplier set nama_sp=:nama,perusahaan_sp=:pt,alamat_sp=:alamat,kontak_sp=:kontak where kd_sp =:kode');
          ParamByName('kode').AsString := edtKdSp.Text;
          ParamByName('nama').AsString := edtNamaSp.Text;
          ParamByName('pt').AsString:=  edtPT.Text;
          ParamByName('alamat').AsString:=  edtAlamat.Text;
          ParamByName('kontak').AsString:=  edtKontak.Text;
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

procedure TFormSuplier.edtKontakKeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in['0'..'9',#8,#13,#32]) then
 begin
   key:=#0;
   showmessage('Masukan No Kontak Dengan Benar');
 end;
end;

procedure TFormSuplier.btnBatalClick(Sender: TObject);
begin
  setCancel;
  loadData;
end;

end.
