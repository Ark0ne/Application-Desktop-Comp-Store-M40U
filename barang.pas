unit barang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,Math,StrUtils,
  ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh;

type
  TFormBarang = class(TForm)
    pnl1: TPanel;
    lblNamaBrg: TLabel;
    lblKdKategori: TLabel;
    lblHargaBeli: TLabel;
    lblKdBrg: TLabel;
    edtNamaBrg: TEdit;
    edtHargaBeli: TEdit;
    edtKdBrg: TEdit;
    cbbNmKat: TComboBox;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnUbah: TBitBtn;
    btnCari: TBitBtn;
    btnKeluar: TBitBtn;
    lblTittle: TLabel;
    pnl2: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    edtHari: TEdit;
    edtHariMaks: TEdit;
    edtTahun: TEdit;
    cbbNmSp: TComboBox;
    edtHargaJual: TEdit;
    edtBiyPesan: TEdit;
    edtBiySimpan: TEdit;
    edtLamaKirim: TEdit;
    edtEoq: TEdit;
    edtRops: TEdit;
    lblHargaJual: TLabel;
    lblBiyPesan: TLabel;
    lblBitSimpan: TLabel;
    lblLamaKirim: TLabel;
    lblEOQ: TLabel;
    lblROPS: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    btnHitung: TBitBtn;
    edtTotalHargaJual: TEdit;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    cbbKdKat: TComboBox;
    cbbKdSp: TComboBox;
    grpButton: TGroupBox;
    rbKd: TRadioButton;
    rbKdKat: TRadioButton;
    rbNama: TRadioButton;
    rbTgl: TRadioButton;
    rbKdSp: TRadioButton;
    dtpMasuk: TDateTimePicker;
    dbgrdBrg: TDBGridEh;
    lblTglMasuk: TLabel;
    btnBatal: TBitBtn;
    procedure hitung;
    procedure loadData;
    procedure seleksiKategori;
    procedure setCancel;
    procedure autoGenerate;
    procedure search;
    procedure setMsgisEmpty;
    procedure setIndexCb;
    procedure onKeyNum(Sender: TObject; var key : Char);
    procedure FormShow(Sender: TObject);
    procedure btnCariClick(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnHitungClick(Sender: TObject);
    procedure cbbNmKatChange(Sender: TObject);
    procedure cbbNmSpChange(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnUbahClick(Sender: TObject);
    procedure btnKeluarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbbKdKatChange(Sender: TObject);
    procedure cbbKdSpChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure dbgrdBrgCellClick(Column: TColumnEh);
    procedure btnBatalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBarang: TFormBarang;

implementation

uses
  datamodul, kontroluser, menu, search_date;

{$R *.dfm}

var
  eoq : Double;

procedure TFormBarang.hitung;
  var
    biysimpan,mTotalSetahun,mBiyPesan,mBiySimpan,mBiySatuan,mLeadTime,mQtyPerhari,mQtyPerhariMaks,mSafetyStock,mROP,mROPS,mTotalHarga,mHargaJual : double;
begin
    mTotalSetahun := 0;
    mBiyPesan :=0;
    mBiySimpan :=0;
    biysimpan:= 0;
    mBiySatuan :=0;
    mHargaJual :=0;
    mLeadTime :=0;
    mQtyPerhari :=0;
    mQtyPerhariMaks :=0;
    mSafetyStock := 0;
    mROP := 0;
    mROPS := 0;
    mTotalHarga :=0;

    biysimpan := StrToFloat(edtHargaBeli.Text)*0.03;
    edtBiySimpan.Text  := FloatToStr(biysimpan);
    mTotalSetahun := StrToFloat(edtTahun.Text);
    mBiyPesan := StrToFloat(edtBiyPesan.Text);
    mBiySimpan:= StrToFloat(edtBiySimpan.Text);
    mHargaJual:= StrToFloat(edtHargaJual.Text);
    mBiySatuan := StrToFloat(edtHargaBeli.Text);
    eoq := Sqrt(2 * (mTotalSetahun * mBiySimpan)/((mBiySimpan * mBiySatuan)/100));
    edtEoq.Text := FormatFloat('0.##', eoq);
    mLeadTime := StrToFloat(edtLamaKirim.Text);
    mQtyPerhari := StrToFloat(edtTahun.Text)/365;
    edtHari.Text := FormatFloat('0.##', mQtyPerhari);
    mQtyPerhariMaks := StrToFloat(edtHariMaks.Text);
    mROP := mQtyPerhari * mLeadTime;
    mSafetyStock := ((mQtyPerhariMaks - mQtyPerhari)* mLeadTime);
    mROPS := mROP + mSafetyStock;
    edtRops.Text := FloatToStr(mROPS);
    mTotalHarga :=  mHargaJual + ((mBiyPesan * 0.5)+(mBiySimpan * 0.3));
    edtTotalHargaJual.Text:= FloatToStr(mTotalHarga);
    if (mTotalSetahun <= mQtyPerhariMaks) then
      begin
        ShowMessage('Jumlah Stok Tahunan Kurang');
        edtTahun.SetFocus;
      end
    else if (mQtyPerhariMaks <= mQtyPerhari) then
      begin
        ShowMessage('Jumlah kebutuhan maksimal Perhari harus > dari kebutuhan rata rata perhari');
        edtHariMaks.SetFocus;
      end
end;

procedure TFormBarang.loadData;
begin
  try
    with DM.zBarang do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from barang');
      Open;
    end;
    with DM.zKategori do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from kategori');
      Open;
    end;
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

procedure TFormBarang.setIndexCb;
begin
  cbbKdKat.ItemIndex := cbbNmKat.ItemIndex;
  cbbKdSp.ItemIndex := cbbNmSp.ItemIndex;
end;

procedure TformBarang.setMsgisEmpty;
begin
  if edtNamaBrg.Text = '' then
    begin
      Application.MessageBox('Nama Barang kosong','Warning',MB_OK or MB_ICONWARNING);
      edtNamaBrg.SetFocus;
    end
  else if (cbbKdKat.Text = '') or (cbbNmKat.Text = '') then
    begin
      Application.MessageBox('Pilih Kategori Barang Yang Tersedia','Warning',MB_OK or MB_ICONWARNING);
      cbbNmKat.SetFocus;
    end
  else if (cbbKdSp.Text = '') or (cbbNmSp.Text = '') then
    begin
      Application.MessageBox('Pilih Nama atau Kode Suplier Yang Tersedia','Warning',MB_OK or MB_ICONWARNING);
      cbbNmSp.SetFocus;
    end
  else if edtHargaBeli.Text = '' then
    begin
      Application.MessageBox('Harga Pembelian kosong','Warning',MB_OK or MB_ICONWARNING);
      edtHargaBeli.SetFocus;
    end
  else if edtHargaJual.Text = ''then
    begin
      Application.MessageBox('Harga Perkiraan Penjualan awal kosong','Warning',MB_OK or MB_ICONWARNING);
      edtHargaJual.SetFocus;
    end
  else if edtBiyPesan.Text = '' then
    begin
      Application.MessageBox('Biaya Pemesanan kosong','Warning',MB_OK or MB_ICONWARNING);
      edtBiyPesan.SetFocus;
    end
  else if edtTahun.Text = '' then
    begin
      Application.MessageBox('Stok Tahunan kosong','Warning',MB_OK or MB_ICONWARNING);
      edtTahun.SetFocus;
    end
  else if edtHariMaks.Text = '' then
    begin
      Application.MessageBox('Perkiraan Maksimal kebutuhan perhari kosong','Warning',MB_OK or MB_ICONWARNING);
      edtHariMaks.SetFocus;
    end
  else if edtLamaKirim.Text = ''then
    begin
      Application.MessageBox('Perkiraan Lama Kirim Kosong','Warning',MB_OK or MB_ICONWARNING);
      edtLamaKirim.SetFocus;
    end
  else
    begin
      hitung;
    end
end;

procedure TFormBarang.seleksiKategori;
begin
  loadData;
  try
    cbbKdKat.Items.Clear;
    cbbNmKat.Items.Clear;
    while not DM.zKategori.Eof do
      begin
        cbbKdKat.Items.Add(DM.zKategori.FieldByName('kd_kat').AsString);
        cbbNmKat.Items.Add(DM.zKategori.FieldByName('nm_kat').AsString);
        DM.zKategori.Next;
      end;
    cbbKdSp.Items.Clear;
    cbbNmSp.Items.Clear;
    while not DM.zSuplier.Eof do
      begin
        cbbKdSp.Items.Add(DM.zSuplier.FieldByName('kd_sp').AsString);
        cbbNmSp.Items.Add(DM.zSuplier.FieldByName('nama_sp').AsString);
        DM.zSuplier.Next;
      end;
  setIndexCb;
  except
    ShowMessage('Gagal Load');
  end;
end;

procedure TFormBarang.setCancel;
begin
  edtTahun.Text := '';
  edtHariMaks.Text := '';
  edtBiySimpan.Text := '';
  edtLamaKirim.Text := '';
  edtEoq.Text := '';
  edtHargaBeli.Text := '';
  edtHari.Text := '';
  edtHargaJual.Text := '';
  edtBiyPesan.Text := '';
  edtRops.Text := '';
  edtTotalHargaJual.Text := '';
  edtNamaBrg.Text := '';
  edtKdBrg.Text := '';
  cbbKdSp.Text := '';
  cbbKdKat.Text := '';
  cbbNmKat.Text:='';
  cbbNmSp.Text:='';
  dtpMasuk.DateTime:=Now;
  rbKd.Checked:=False;
  rbKdKat.Checked:=False;
  rbNama.Checked:=false;
  rbTgl.Checked:=False;
  rbKdSp.Checked:= False;
  btnHapus.Enabled:=False;
  btnUbah.Enabled:=False;
end;

procedure TFormBarang.autoGenerate;
var
  leftb : string;
begin
  leftb := UpperCase(LeftStr(edtNamaBrg.Text,1));
  edtKdBrg.Text := leftb + FormatDateTime('mss',Now);
end;

procedure TFormBarang.search;
var
  msg : string;
begin
  if rbKd.Checked then
  begin
    msg := InputBox('Masukan Kode Barang','Field Kode Barang','');
    if msg <> '' then
      begin
        edtKdBrg.Text := msg;
        with DM.zBarang do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from barang where kd_brg like '+''''+'%'+edtKdBrg.Text+'%'+'''');
          ExecSQL;
          Open;
        end;
      end
      else
        setCancel;
  end
  else if rbKdKat.Checked then
  begin
     msg := InputBox('Masukan Kode Kategori','Field Kode Kategori','');
    if msg <> '' then
      begin
        cbbKdKat.Text := msg;
        with DM.zBarang do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from barang where kd_kat like '+''''+'%'+cbbKdKat.Text+'%'+'''');
          ExecSQL;
          Open;
        end;
      end
      else
        setCancel;
  end
  else if rbKdSp.Checked then
  begin
      msg := InputBox('Masukan Kode Suplier','Field Kode Suplier','');
    if msg <> '' then
      begin
        cbbKdSp.Text := msg;
        with DM.zBarang do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from barang where kd_sp like '+''''+'%'+cbbKdSp.Text+'%'+'''');
          ExecSQL;
          Open;
        end;
      end
      else
        setCancel;
  end
  else if rbNama.Checked then
  begin
    msg := InputBox('Masukan Nama Barang','Field Barang','');
    if msg <> '' then
      begin
        edtNamaBrg.Text := msg;
        with DM.zBarang do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from barang where nm_brg like '+''''+'%'+edtNamaBrg.Text+'%'+'''');
          ExecSQL;
          Open;
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

procedure TFormBarang.onKeyNum(Sender: TObject; var key : Char);
begin
  if not (key in['0'..'9',#8,#13,#32]) then
    begin
      key:=#0;
      showmessage('Masukan Tipe Numeric');
    end;
end;

procedure TFormBarang.FormShow(Sender: TObject);
begin
  loadData;
  seleksiKategori;
  setCancel;
  setIndexCb;
end;

procedure TFormBarang.btnCariClick(Sender: TObject);
begin
search;
end;

procedure TFormBarang.btnSimpanClick(Sender: TObject);
begin
  setMsgisEmpty;
  autoGenerate;
  if (edtNamaBrg.Text <> '') and (cbbKdKat.Text <> '') and (cbbNmKat.Text <> '') and (cbbKdSp.Text <> '') and (cbbNmSp.Text <> '') and (edtHargaBeli.Text <> '')and (edtHargaJual.Text <> '') and(edtBiyPesan.Text <> '') and (edtTahun.Text <> '') and (edtHariMaks.Text <> '')then
  begin
      if MessageDlg('[Kode Barang : ' +edtKdBrg.Text+ '][Nama Barang : '+edtNamaBrg.Text+'][Kategori : '+cbbKdKat.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
       try
        begin
          with  DM.zBarang do
          begin
          Close;
          SQL.Clear;
          SQL.Add('insert into barang(kd_brg,nm_brg,kd_kat,kd_sp,harga_beli,harga_jual,tgl_brg,qty_thn,biy_pesan,biy_simpan,qty_hari_max,qty_eoq,lead_time,jual_total,rop_safety)');
          SQL.Add('values(:kode,:nama,:kat,:sup,:beli,:jual,:tgl,:stok,:pesan,:simpan,:maks,:eoq,:lama,:total,:rops)');
          ParamByName('kode').AsString := edtKdBrg.Text;
          ParamByName('nama').AsString := edtNamaBrg.Text;
          ParamByName('kat').AsString := cbbKdKat.Text;
          ParamByName('sup').AsString := cbbKdSp.Text;
          ParamByName('beli').AsString := edtHargaBeli.Text;
          ParamByName('jual').AsString := edtHargaJual.Text;
          ParamByName('tgl').AsDate := dtpMasuk.Date;
          ParamByName('stok').AsString := edtTahun.Text;
          ParamByName('pesan').AsString := edtBiyPesan.Text;
          ParamByName('simpan').AsString := edtBiySimpan.Text;
          ParamByName('maks').AsString := edtHariMaks.Text;
          ParamByName('eoq').AsString := edtEoq.Text;
          ParamByName('lama').AsString := edtLamaKirim.Text;
          ParamByName('total').AsString := edtTotalHargaJual.Text;
          ParamByName('rops').AsString := edtRops.Text;
          ExecSQL;
          SQL.Clear;
          SQL.Add('select * from barang');
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

procedure TFormBarang.btnHitungClick(Sender: TObject);
begin
  setMsgisEmpty;
end;

procedure TFormBarang.cbbNmKatChange(Sender: TObject);
begin
  setIndexCb;
end;

procedure TFormBarang.cbbNmSpChange(Sender: TObject);
begin
  cbbKdSp.ItemIndex:=cbbNmSp.ItemIndex;
  setIndexCb;
end;

procedure TFormBarang.btnHapusClick(Sender: TObject);
begin
if edtKdBrg.Text <> '' then
  begin
  try
    if MessageDlg('Yakin ingin menghapus [Kode Id User : ' +edtKdBrg.Text+ '][Nama Barang : '+edtNamaBrg.Text+'][Kategori : '+cbbKdKat.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        begin
          with  DM.zBarang do
          begin
          Close;
          SQL.Clear;
          SQL.Add('delete from barang where kd_brg = "'+edtKdBrg.Text+'"');
          ExecSQL;
          SQL.Clear;
          SQL.Add('select * from barang');
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
    Application.MessageBox('Kode Barang  Tidak Terpilih','Information',MB_OK or MB_ICONINFORMATION)
  end

end;

procedure TFormBarang.btnUbahClick(Sender: TObject);
begin
  setMsgisEmpty;
  hitung;
  if (edtNamaBrg.Text <> '') and (cbbKdKat.Text <> '') and (cbbNmKat.Text <> '') and (cbbKdSp.Text <> '') and (cbbNmSp.Text <> '') and (edtHargaBeli.Text <> '')and (edtHargaJual.Text <> '') and(edtBiyPesan.Text <> '') and (edtTahun.Text <> '') and (edtHariMaks.Text <> '')then
  begin
    if MessageDlg('[Kode Barang : ' +edtKdBrg.Text+ '][Nama Barang : '+edtNamaBrg.Text+'][Kategori : '+cbbKdKat.Text+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
       try
        begin
          with  DM.zBarang do
          begin
          Close;
          SQL.Clear;
          SQL.Add('update barang set nm_brg=:nama,kd_kat=:kat,kd_sp=:sup,harga_beli=:beli,harga_jual=:jual,tgl_brg=:tgl,qty_thn=:stok,biy_pesan=:pesan,biy_simpan=:simpan,qty_hari_max=:maks,qty_eoq=:eoq,lead_time=:lama,jual_total=:total,rop_safety=:rops where kd_brg =:kode');
          ParamByName('kode').AsString := edtKdBrg.Text;
          ParamByName('nama').AsString := edtNamaBrg.Text;
          ParamByName('kat').AsString := cbbKdKat.Text;
          ParamByName('sup').AsString := cbbKdSp.Text;
          ParamByName('beli').AsString := edtHargaBeli.Text;
          ParamByName('jual').AsString := edtHargaJual.Text;
          ParamByName('tgl').AsDate := dtpMasuk.Date;
          ParamByName('stok').AsString := edtTahun.Text;
          ParamByName('pesan').AsString := edtBiyPesan.Text;
          ParamByName('simpan').AsString := edtBiySimpan.Text;
          ParamByName('maks').AsString := edtHariMaks.Text;
          ParamByName('eoq').AsString := edtEoq.Text;
          ParamByName('lama').AsString := edtLamaKirim.Text;
          ParamByName('total').AsString := edtTotalHargaJual.Text;
          ParamByName('rops').AsString := edtRops.Text;
          ExecSQL;
          SQL.Clear;
          SQL.Add('select * from barang');
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

procedure TFormBarang.btnKeluarClick(Sender: TObject);
begin
  formmenu.show;
  hide;
end;

procedure TFormBarang.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= False;
end;

procedure TFormBarang.cbbKdKatChange(Sender: TObject);
begin
  cbbNmKat.ItemIndex:=cbbKdKat.ItemIndex;
  setIndexCb;
end;

procedure TFormBarang.cbbKdSpChange(Sender: TObject);
begin
  cbbNmSp.ItemIndex:=cbbKdSp.ItemIndex;
  setIndexCb;
end;

procedure TFormBarang.FormCreate(Sender: TObject);
begin
  setCancel;
end;

procedure TFormBarang.btnCancelClick(Sender: TObject);
begin
  setCancel;
  loadData;
  seleksiKategori;
end;

procedure TFormBarang.dbgrdBrgCellClick(Column: TColumnEh);
begin
  setCancel;
  btnHapus.Enabled:=True;
  btnUbah.Enabled:=True;
  try
    with DM.zBarang do
    begin
    edtKdBrg.Text:= Fields[0].AsString;
    edtNamaBrg.Text:= Fields[1].AsString;
    cbbKdKat.Text:= Fields[2].AsString;
    cbbKdSp.Text:= Fields[3].AsString;
    edtHargaBeli.Text := Fields[4].AsString;
    edtHargaJual.Text := Fields[5].AsString;
    dtpMasuk.DateTime := Fields[6].AsDateTime;
    edtTahun.Text := Fields[7].AsString;
    edtBiyPesan.Text := Fields[8].AsString;
    edtBiySimpan.Text := Fields[9].AsString;
    edtHariMaks.Text := Fields[10].AsString;
    edtEoq.Text := Fields[11].AsString;
    edtLamaKirim.Text := Fields[12].AsString;
    edtTotalHargaJual.Text := Fields[13].AsString;
    edtRops.Text := Fields[14].AsString;
    end;
  cbbNmKat.SetFocus;
  except
    ShowMessage('Tidak dapat mengambil nilai');
  end;
end;

procedure TFormBarang.btnBatalClick(Sender: TObject);
begin
  setCancel;
  loadData;
  seleksiKategori;
end;

end.
