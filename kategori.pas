unit kategori;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, ComCtrls, StrUtils,
  Mask, DBCtrlsEh, DBGridEhGrouping, GridsEh, DBGridEh, Menus, PrnDbgeh;

type
  TFormKategori = class(TForm)
    pnl1: TPanel;
    lblUserName: TLabel;
    lblIdUser: TLabel;
    edtNamaKat: TEdit;
    edtKdKat: TEdit;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnUbah: TBitBtn;
    btnCari: TBitBtn;
    btnKeluar: TBitBtn;
    lblTittle: TLabel;
    dtpDate: TDateTimePicker;
    lblTglDitambahkan: TLabel;
    rbKd: TRadioButton;
    rbNama: TRadioButton;
    rbTgl: TRadioButton;
    dbgrdKat: TDBGridEh;
    btnBatal: TBitBtn;
    procedure autoGenerate;
    procedure setCancel;
    procedure setMsgisEmpty;
    procedure loadData;
    procedure search;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCariClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnKeluarClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure dbgrdKatCellClick(Column: TColumnEh);
    procedure btnUbahClick(Sender: TObject);
    procedure btnBatalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormKategori: TFormKategori;

implementation

uses
  datamodul, menu, search_date;

{$R *.dfm}

procedure TFormKategori.autoGenerate;
var
  leftk : string;
begin
  leftk := UpperCase(LeftStr(edtNamaKat.Text,3));
  edtKdKat.Text := leftk + FormatDateTime('ddmmyyhhmmss',Now);
end;

procedure TFormKategori.setCancel;
begin
   edtKdKat.Text :='';
   edtNamaKat.Text :='';
   dtpDate.DateTime:=Now;
   rbKd.Checked:=False;
   rbNama.Checked:=false;
   rbTgl.Checked:=False;
   btnHapus.Enabled:=False;
   btnUbah.Enabled:=False;
end;

procedure TFormKategori.setMsgisEmpty;
begin
  if edtKdKat.Text = '' then
  begin
    Application.MessageBox('Kode Kategori Barang Kosong','Warning',MB_OK or MB_ICONWARNING);
  end
  else if edtNamaKat.Text = '' then
  begin
    Application.MessageBox('Nama Kategori Barang kosong','Warning',MB_OK or MB_ICONWARNING);
    edtNamaKat.SetFocus;
  end
end;

procedure TFormKategori.loadData;
begin
   try
    with DM.zKategori do
    begin
    Close;
    SQL.Clear;
    SQL.Add('select * from kategori');
    Open;
    end;
    except
      ShowMessage('Gagal Mengambil Data Dari Database');
  end;
end;

procedure TFormKategori.search;
var
  msg : string;
begin
  if rbKd.Checked then
    begin
    msg := InputBox('Masukan Kode Kategori Barang','Field Kode Kategori','');
    if msg <> '' then
      begin
        edtKdKat.Text := msg;
        with DM.zKategori do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from kategori where kd_kat like '+''''+'%'+edtKdKat.Text+'%'+'''');
          Open;
        setCancel;
        edtKdKat.Text:=msg;
        end;
      end
      else
        setCancel
  end
  else if rbNama.Checked then
  begin
    msg := InputBox('Masukan Nama Kategori Barang','Field Nama Kategori Barang','');
    if msg <> '' then
      begin
        edtNamaKat.Text := msg;
        with DM.zKategori do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from kategori where nm_kat LIKE '+''''+'%'+edtNamaKat.Text+'%'+'''');
          Open;
          setCancel;
          edtNamaKat.Text:=msg;
        end;
      end
      else
        setCancel;
  end
  else if rbTgl.Checked then
  begin
    FormSearchDate.Show;
  end
  else
  begin
    Application.MessageBox('Silahkan Checklist pencarian','Information',MB_OK or MB_ICONINFORMATION)
  end;

end;

procedure TFormKategori.dbgrdKatCellClick(Column: TColumnEh);
begin
  btnHapus.Enabled:=True;
  btnUbah.Enabled:=True;
  try
    with DM.zKategori do
    begin
    edtKdKat.Text:= Fields[0].AsString;
    edtNamaKat.Text:= Fields[1].AsString;
    dtpDate.DateTime := Fields[2].AsDateTime;
    end;
  except
    ShowMessage('Tidak dapat mengambil nilai');
  end;
end;

procedure TFormKategori.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= False;
end;

procedure TFormKategori.FormCreate(Sender: TObject);
begin
  setCancel;
end;

procedure TFormKategori.FormShow(Sender: TObject);
begin
  setCancel;
  loadData;
end;

procedure TFormKategori.btnCancelClick(Sender: TObject);
begin
  setCancel;
  loadData;
end;

procedure TFormKategori.btnCariClick(Sender: TObject);
begin
  search;
end;

procedure TFormKategori.btnKeluarClick(Sender: TObject);
begin
  formmenu.show;
  hide;
end;

procedure TFormKategori.btnSimpanClick(Sender: TObject);
begin
  autoGenerate;
  setMsgisEmpty;
  if ((edtKdKat.Text <> '') and (edtNamaKat.Text <> '')) then
  begin
      if MessageDlg('[Kode Kategori : ' +edtKdKat.Text+ '][Nama Kategori : '+edtNamaKat.Text+'][Tanggal : '+DateToStr(dtpDate.Date)+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
       try
        begin
          with  DM.zKategori do
          begin
          Close;
          SQL.Clear;
          SQL.Add('insert into kategori(kd_kat,nm_kat,tgl_kat)');
          SQL.Add('values(:kode,:nama,:tgl)');
          ParamByName('kode').AsString := edtKdKat.Text;
          ParamByName('nama').AsString := edtNamaKat.Text;
          ParamByName('tgl').AsDate:=  dtpDate.Date;
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

procedure TFormKategori.btnHapusClick(Sender: TObject);
begin
  if edtKdKat.Text <> '' then
  begin
  try
    if MessageDlg('Yakin ingin menghapus [Kode Kategori Barang : ' +edtKdKat.Text+ '][Nama Kategori Barang : '+edtNamaKat.Text+'][Tanggal : '+DateToStr(dtpDate.Date)+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        begin
          with  DM.zKategori do
          begin
          Close;
          SQL.Clear;
          SQL.Add('delete from kategori where kd_kat = "'+edtKdKat.Text+'"');
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
    Application.MessageBox('Kode Kategori Barang  Tidak Terpilih','Information',MB_OK or MB_ICONINFORMATION)
  end
end;

procedure TFormKategori.btnUbahClick(Sender: TObject);
begin
  setMsgisEmpty;
    if MessageDlg('[Kode Kategori Barang : ' +edtKdKat.Text+ '][Nama Kategori Barang : '+edtNamaKat.Text+'][Tanggal : '+DateToStr(dtpDate.Date)+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        try
        begin
          with  DM.zKategori do
          begin
          Close;
          SQL.Clear;
          SQL.Add('update kategori set nm_kat=:nama,tgl_kat=:tgl where kd_kat =:kode');
          ParamByName('kode').AsString := edtKdKat.Text;
          ParamByName('nama').AsString := edtNamaKat.Text;
          ParamByName('tgl').AsDate := dtpDate.Date;
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

procedure TFormKategori.btnBatalClick(Sender: TObject);
begin
  setCancel;
  loadData;
end;

end.
