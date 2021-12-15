unit penjualan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,
  DBGridEhGrouping, Mask, DBCtrlsEh, GridsEh, DBGridEh,StrUtils;

type
  TFormPenjualan = class(TForm)
    pnl1: TPanel;
    lblUserName: TLabel;
    lblTgl: TLabel;
    lblAlamat: TLabel;
    lblKdPbl: TLabel;
    lblJns: TLabel;
    edtNamaPbl: TEdit;
    edtKdPjl: TEdit;
    edtAlamat: TEdit;
    btnSimpan: TBitBtn;
    btnHapus: TBitBtn;
    btnUbah: TBitBtn;
    btnCari: TBitBtn;
    btnKeluar: TBitBtn;
    lblTittle: TLabel;
    pnl2: TPanel;
    lblEmail: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblKontak: TLabel;
    edtEmail: TEdit;
    edtPT: TEdit;
    edtKontak: TEdit;
    cbbJenisPbl: TComboBox;
    dtpPbl: TDateTimePicker;
    lblNamaBrg: TLabel;
    cbbNamaBrg: TComboBox;
    cbbJmlStok: TDBComboBoxEh;
    cbbKdBrg: TComboBox;
    lblDisc: TLabel;
    lblHarga: TLabel;
    cbbHarga: TDBComboBoxEh;
    lblTotal: TLabel;
    edtTotal: TEdit;
    edtJmlBeli: TEdit;
    lblJmlBeli: TLabel;
    edtDiscount: TEdit;
    grpButton: TGroupBox;
    rbKd: TRadioButton;
    rbKdBrg: TRadioButton;
    rbNama: TRadioButton;
    rbTgl: TRadioButton;
    rbPT: TRadioButton;
    dbgrdPjl: TDBGridEh;
    edtJumBeliUp: TEdit;
    lblAwalPembelian: TLabel;
    lblUpdatePembelian: TLabel;
    btnBatal: TBitBtn;
    procedure autoGenerate;
    procedure setCancel;
    procedure setMsgisEmpty;
    procedure discountHitung;
    procedure setIndexCb;
    procedure loadData;
    procedure seleksiKategori;
    procedure search;
    procedure onKeyNum(Sender: TObject; var key : Char);
    procedure btnKeluarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCariClick(Sender: TObject);
    procedure cbbNamaBrgChange(Sender: TObject);
    procedure cbbJenisPblChange(Sender: TObject);
    procedure cbbKdBrgChange(Sender: TObject);
    procedure btnSimpanClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnUbahClick(Sender: TObject);
    procedure dbgrdPjlCellClick(Column: TColumnEh);
    procedure btnBatalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPenjualan: TFormPenjualan;

implementation

uses menu, datamodul, search_date;

{$R *.dfm}

procedure TFormPenjualan.autoGenerate;
var
  leftp: string;
begin
  leftp := UpperCase(LeftStr(edtNamaPbl.Text,3));
  edtKdPjl.Text := 'PJ' + leftp + FormatDateTime('ddmmyyss',Now);
end;

procedure TFormPenjualan.setCancel;
begin
   edtKdPjl.Text :='';
   edtNamaPbl.Text :='';
   edtPT.Text:='';
   edtAlamat.Text:='';
   edtKontak.Text:='';
   edtEmail.Text:='';
   edtTotal.Text:='';
   edtJmlBeli.Text:='';
   edtJumBeliUp.Text:='';
   edtDiscount.Text:='';
   dtpPbl.DateTime:= Now;
   cbbNamaBrg.Text:='';
   cbbKdBrg.Text:='';
   cbbJenisPbl.Text:='';
   cbbJmlStok.Text:='';
   cbbHarga.Text:='';
   rbKd.Checked:=False;
   rbKdBrg.Checked:=False;
   rbNama.Checked:=false;
   rbTgl.Checked:=False;
   rbPT.Checked:= False;
   btnHapus.Enabled:=False;
   btnUbah.Enabled:=False;
   edtJumBeliUp.Enabled:=False;
   edtJmlBeli.Enabled:=True;
end;

procedure TFormPenjualan.setMsgisEmpty;
begin
  if cbbNamaBrg.Text = '' then
  begin
    Application.MessageBox('Silahkan Pilih Barang','Warning',MB_OK or MB_ICONWARNING);
    cbbNamaBrg.SetFocus;
  end
  else if cbbKdBrg.Text = '' then
  begin
    Application.MessageBox('Silahkan Pilih Barang','Warning',MB_OK or MB_ICONWARNING);
  end
  else if edtNamaPbl.Text = '' then
  begin
    Application.MessageBox('Nama Pembeli Tidak Boleh Kosong','Warning',MB_OK or MB_ICONWARNING);
    edtNamaPbl.SetFocus;
  end
  else if edtAlamat.Text = '' then
  begin
    Application.MessageBox('Alamat Pembeli Tidak Boleh kosong','Warning',MB_OK or MB_ICONWARNING);
    edtAlamat.SetFocus;
  end
  else if cbbJmlStok.Text = '' then
  begin
    Application.MessageBox('Silahkan Pilih Barang','Warning',MB_OK or MB_ICONWARNING);
  end
  else if cbbHarga.Text = '' then
  begin
    Application.MessageBox('Silahkan Pilih Barang','Warning',MB_OK or MB_ICONWARNING);
  end
  else if edtJmlBeli.Text = ''  then
  begin
     Application.MessageBox('Jumlah Pembelian Kosong','Warning',MB_OK or MB_ICONWARNING);
     edtJmlBeli.SetFocus;
  end
  else if cbbJenisPbl.Text = '' then
  begin
    Application.MessageBox('Silahkan Pilih Jenis Pembelian','Warning',MB_OK or MB_ICONWARNING);
    cbbJenisPbl.SetFocus;
  end
  else  if (cbbJenisPbl.Text = 'Personal') or (cbbJenisPbl.Text = 'Reseller') then
  begin
    if edtKontak.Text = '' then
    begin
      Application.MessageBox('Wajib isikan Kontak Anda Bila Pembelian Personal atau Reseller','Warning',MB_OK or MB_ICONWARNING);
      edtKontak.SetFocus
    end;
  end
  else if cbbJenisPbl.Text = 'Perusahaan' then
  begin
    if edtPT.Text = '' then
    begin
      Application.MessageBox('Wajib isikan Nama Perusahaan Anda','Warning',MB_OK or MB_ICONWARNING);
      edtPT.SetFocus
    end;
  end;
end;

procedure TFormPenjualan.discountHitung;
var
  discount,total,jumlahTotal,jumbeli: Double;
begin
  //edtTotal.Text := FloatToStr(total);
  jumbeli:= StrToFloat(edtJmlBeli.Text);
  if edtJumBeliUp.Text <> '' then
  begin
    jumbeli:= StrToFloat(edtJumBeliUp.Text)
  end;

  total := jumbeli * StrToFloat(cbbHarga.Text);
  if cbbJenisPbl.Text = 'Personal' then
  begin
    if  (jumbeli >= 3) and (jumbeli < 10)  then
    begin
      discount := 0.02 * total;
    end
    else if jumbeli >= 10 then
    begin
      discount := 0.05 * total;
    end;
  end
  else if cbbJenisPbl.Text = 'Perusahaan' then
  begin
    if  (jumbeli >= 5) and (jumbeli < 10) then
    begin
      discount := 0.05 * total;
    end
    else if (jumbeli >= 10) and (jumbeli < 20) then
    begin
      discount := 0.08 * total;
    end
    else if  (jumbeli >= 20) and (jumbeli < 30) then
    begin
      discount := 0.1 * total;
    end
    else if jumbeli >= 30 then
    begin
      discount := 0.15 * total;
    end;
  end
  else if cbbJenisPbl.Text = 'Reseller' then
  begin
    if  (jumbeli >= 5) and (jumbeli < 15) then
    begin
      discount := 0.04 * total;
    end
    else if (jumbeli >= 15) and (jumbeli < 25) then
    begin
      discount := 0.07 * total;
    end
    else if  (jumbeli >= 25) and (jumbeli < 35) then
    begin
      discount := 0.1 * total;
    end
    else if jumbeli >= 35 then
    begin
      discount := 0.15 * total;
    end;
  end;
  jumlahTotal := total - discount;
  edtDiscount.Text := FormatFloat('0.##', discount);
  edtTotal.Text := FormatFloat('0.##', jumlahTotal);

end;

procedure TFormPenjualan.setIndexCb;
begin
  cbbKdBrg.ItemIndex := cbbNamaBrg.ItemIndex;
  cbbJmlStok.ItemIndex := cbbNamaBrg.ItemIndex;
  cbbHarga.ItemIndex := cbbNamaBrg.ItemIndex;
  //Type
  if (cbbJenisPbl.Text = 'Personal') or (cbbJenisPbl.Text = 'Reseller') then
  begin
    edtPT.Enabled:= False;
  end
  else if cbbJenisPbl.Text = 'Perusahaan' then
  begin
    edtPT.Enabled:= True;
  end;

end;

procedure TFormPenjualan.loadData;
begin
   try
    with DM.zPenjualan do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from penjualan');
      Open;
    end;
     with DM.zBarang do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from barang');
      Open;
    end;
    except
      ShowMessage('Gagal Mengambil Data Dari Database');
  end;
end;

procedure TFormPenjualan.seleksiKategori;
begin
  try
    loadData;
    cbbKdBrg.Items.Clear;
    cbbNamaBrg.Items.Clear;
    cbbJmlStok.Items.Clear;
    cbbHarga.Items.Clear;
    while not DM.zBarang.Eof do
      begin
        cbbKdBrg.Items.Add(DM.zBarang.FieldByName('kd_brg').AsString);
        cbbNamaBrg.Items.Add(DM.zBarang.FieldByName('nm_brg').AsString);
        cbbJmlStok.Items.Add(DM.zBarang.FieldByName('qty_thn').AsString);
        cbbHarga.Items.Add(DM.zBarang.FieldByName('jual_total').AsString);
        DM.zBarang.Next;
      end;
  setIndexCb;
  except
    ShowMessage('Gagal Load');
  end;
end;

procedure TFormPenjualan.search;
var
  msg : string;
begin
  if rbKd.Checked then
    begin
    msg := InputBox('Masukan Kode Penjualan','Field Kode Penjualan','');
    if msg <> '' then
      begin
        edtKdPjl.Text := msg;
        with DM.zPenjualan do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from penjualan where kd_pjl like '+''''+'%'+edtKdPjl.Text+'%'+'''');
          Open;
        setCancel;
        edtKdPjl.Text:=msg;
        end;
      end
      else
        setCancel;
  end
  else if rbKdBrg.Checked then
  begin
     msg := InputBox('Masukan Kode Barang','Field Kode Barang','');
    if msg <> '' then
      begin
        cbbKdBrg.Text := msg;
        with DM.zPenjualan do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from penjualan where kd_brg LIKE '+''''+'%'+cbbKdBrg.Text+'%'+'''');
          Open;
          setCancel;
          cbbKdBrg.Text:=msg;
        end;
      end
      else
        setCancel;
  end
  else if rbNama.Checked then
  begin
    msg := InputBox('Masukan Nama Pembeli','Field Nama Pembeli','');
    if msg <> '' then
      begin
        edtNamaPbl.Text := msg;
        with DM.zPenjualan do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from penjualan where nm_pbl LIKE '+''''+'%'+edtNamaPbl.Text+'%'+'''');
          Open;
          setCancel;
          edtNamaPbl.Text:=msg;
        end;
      end
      else
        setCancel;
  end
  else if rbPT.Checked then
  begin
     msg := InputBox('Masukan Nama Perusahaan Pembeli','Field Nama Perusahaan Pembeli','');
    if msg <> '' then
      begin
        edtPT.Text := msg;
        with DM.zPenjualan do
        begin
          Active:=False;
          SQL.Clear;
          Close;
          SQL.Add('select * from penjualan where perusahaan_pbl LIKE '+''''+'%'+edtPT.Text+'%'+'''');
          Open;
          setCancel;
          edtPT.Text:=msg;
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

procedure TFormPenjualan.onKeyNum(Sender: TObject; var key : Char);
begin
  if not (key in['0'..'9',#8,#13,#32]) then
    begin
      key:=#0;
      showmessage('Masukan Tipe Numeric');
    end;
end;

procedure TFormPenjualan.dbgrdPjlCellClick(Column: TColumnEh);
begin
  setCancel;
  btnHapus.Enabled:=True;
  btnUbah.Enabled:=True;
  edtJumBeliUp.Enabled:=True;
  edtJmlBeli.Enabled:=False;
  cbbJmlStok.Text := 'Silahkan Pilih Barang';
  cbbHarga.Text := 'Silahkan Pilih Barang';
  try
    with DM.zPenjualan do
    begin
    edtKdPjl.Text:= Fields[0].AsString;
    cbbKdBrg.Text:=Fields[1].AsString;
    dtpPbl.DateTime := Fields[2].AsDateTime;
    edtNamaPbl.Text:= Fields[3].AsString;
    edtAlamat.Text:= Fields[4].AsString;
    edtKontak.Text:= Fields[5].AsString;
    edtEmail.Text:= Fields[6].AsString;
    edtPT.Text:= Fields[7].AsString;
    edtJmlBeli.Text:= Fields[8].AsString;
    edtTotal.Text:= Fields[9].AsString;
    end;
  cbbNamaBrg.SetFocus;
  except
    ShowMessage('Tidak dapat mengambil nilai');
  end;
end;

procedure TFormPenjualan.btnKeluarClick(Sender: TObject);
begin
   formmenu.show;
  hide;
end;

procedure TFormPenjualan.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= False;
end;

procedure TFormPenjualan.FormCreate(Sender: TObject);
begin
  setCancel;
end;

procedure TFormPenjualan.FormShow(Sender: TObject);
begin
  loadData;
  seleksiKategori;
  setCancel;
  setIndexCb;
end;

procedure TFormPenjualan.btnCariClick(Sender: TObject);
begin
  search;
end;

procedure TFormPenjualan.cbbNamaBrgChange(Sender: TObject);
begin
  setIndexCb;
end;

procedure TFormPenjualan.cbbJenisPblChange(Sender: TObject);
begin
  setIndexCb;
end;

procedure TFormPenjualan.cbbKdBrgChange(Sender: TObject);
begin
  cbbNamaBrg.ItemIndex:=cbbKdBrg.ItemIndex;
  setIndexCb;
end;

procedure TFormPenjualan.btnSimpanClick(Sender: TObject);
var
  jumStok : Double;
begin
  autoGenerate;
  setMsgisEmpty;
  if (StrToFloat(edtJmlBeli.Text)) > (StrToFloat(cbbJmlStok.Text)) then
  begin
     Application.MessageBox('Jumlah Pembelian Melebihi Stok Yang Ada','Warning',MB_OK or MB_ICONWARNING);
     edtJmlBeli.SetFocus;
  end
  else
  begin
  if (cbbNamaBrg.Text <> '') and (cbbKdBrg.Text <> '') and (edtNamaPbl.Text <> '') and (edtAlamat.Text <> '') and (cbbJenisPbl.Text <> '') and(edtJmlBeli.Text <> '') then
  begin
  discountHitung;
    if (edtKontak.Text <> '') or (edtPT.Text <> '') then
     begin
      if MessageDlg('[Kode Penjualan : ' +edtKdPjl.Text+ '][Nama Pembeli : '+edtNamaPbl.Text+'][Tanggal : '+DateToStr(dtpPbl.Date)+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        try
          begin
            with  DM.zPenjualan do
            begin
            Close;
            SQL.Clear;
            SQL.Add('insert into penjualan(kd_pjl,kd_brg,tgl_pjl,nm_pbl,alamat_pbl,kontak_pbl,email_pbl,perusahaan_pbl,jumlah_pbl,total_harga)');
            SQL.Add('values(:kode,:kodebrg,:tgl,:nama,:alamat,:kontak,:email,:pt,:jumlah,:total)');
            ParamByName('kode').AsString := edtKdPjl.Text;
            ParamByName('kodebrg').AsString := cbbKdBrg.Text;
            ParamByName('tgl').AsDate := dtpPbl.Date;
            ParamByName('nama').AsString := edtNamaPbl.Text;
            ParamByName('alamat').AsString := edtAlamat.Text;
            ParamByName('kontak').AsString := edtKontak.Text;
            ParamByName('email').AsString := edtEmail.Text;
            ParamByName('pt').AsString := edtPT.Text;
            ParamByName('jumlah').AsString := edtJmlBeli.Text;
            ParamByName('total').AsString := edtTotal.Text;
            ExecSQL;
            SQL.Clear;
            loadData;
            Open;
            with DM.zBarang do
              begin
              Close;
              SQL.Clear;
              SQL.Add('update barang set qty_thn=:stok where kd_brg=:kode');
              ParamByName('kode').AsString := cbbKdBrg.Text;
              jumStok := (StrToFloat(cbbJmlStok.Text) - StrToFloat(edtJmlBeli.Text));
              ParamByName('stok').AsString := FloatToStr(jumStok);
              ExecSQL;
              SQL.Clear;
              loadData;
              Open;
              end;
            end;
            ShowMessage('Data Berhasil Disimpan');
            setCancel;
            seleksiKategori;
          end;
        except
          ShowMessage('Data Gagal Disimpan');
        end;
      end;
    end;
  end;
end;

procedure TFormPenjualan.btnCancelClick(Sender: TObject);
begin
  setCancel;
  loadData;
  seleksiKategori;
end;

procedure TFormPenjualan.btnHapusClick(Sender: TObject);
begin
  if edtKdPjl.Text <> '' then
  begin
  try
    if MessageDlg('Yakin ingin menghapus [Kode Penjualan : ' +edtKdPjl.Text+ '][Nama Pembeli : '+edtNamaPbl.Text+'][Tanggal Penjualan : '+DateToStr(dtpPbl.Date)+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        begin
          with  DM.zPenjualan do
          begin
          Close;
          SQL.Clear;
          SQL.Add('delete from penjualan where kd_pjl = "'+edtKdPjl.Text+'"');
          ExecSQL;
          SQL.Clear;
          SQL.Add('select * from penjualan');
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
    Application.MessageBox('Kode Penjualan Tidak Terpilih','Information',MB_OK or MB_ICONINFORMATION)
  end
end;

procedure TFormPenjualan.btnUbahClick(Sender: TObject);
var
  firstData,secondData,result,jumStok : Double;
begin
  setMsgisEmpty;
  if (cbbNamaBrg.Text <> '') and (cbbKdBrg.Text <> '') and (edtNamaPbl.Text <> '')  and (edtAlamat.Text <> '')and (cbbJenisPbl.Text <> '') and (edtJmlBeli.Text <> '') then
  begin
  discountHitung;
    if (edtKontak.Text <> '') or (edtPT.Text <> '') then
     begin
      if MessageDlg('[Kode Penjualan : ' +edtKdPjl.Text+ '][Nama Pembeli : '+edtNamaPbl.Text+'][Tanggal : '+DateToStr(dtpPbl.Date)+']',mtConfirmation, [mbYes]+ [mbNo], 0) = mryes then
        try
          begin
            with  DM.zPenjualan do
            begin
            Close;
            SQL.Clear;
            SQL.Add('update penjualan set kd_brg=:kodebrg,tgl_pjl=:tgl,nm_pbl=:nama,alamat_pbl=:alamat,kontak_pbl=:kontak,email_pbl=:email,perusahaan_pbl=:pt,jumlah_pbl=:jumlah,total_harga=:total where kd_pjl=:kode');
            //SQL.Add('values(:kode,:kodebrg,:tgl,:nama,:alamat,:kontak,:email,:pt,:jumlah,:total)');
            ParamByName('kode').AsString := edtKdPjl.Text;
            ParamByName('kodebrg').AsString := cbbKdBrg.Text;
            ParamByName('tgl').AsDate := dtpPbl.Date;
            ParamByName('nama').AsString := edtNamaPbl.Text;
            ParamByName('alamat').AsString := edtAlamat.Text;
            ParamByName('kontak').AsString := edtKontak.Text;
            ParamByName('email').AsString := edtEmail.Text;
            ParamByName('pt').AsString := edtPT.Text;
            ParamByName('jumlah').AsString := edtJmlBeli.Text;
            ParamByName('total').AsString := edtTotal.Text;
            ExecSQL;
            SQL.Clear;
            loadData;
            Open;
            end;
            if (edtJumBeliUp.Text <> '') and (StrToFloat(edtJumBeliUp.Text) < StrToFloat(cbbJmlStok.Text)) then
              begin
              firstData := strToFloat(edtJmlBeli.Text); //10  5
              secondData := StrToFloat(edtJumBeliUp.Text); //5   10
              if secondData > firstData then
              begin
                result:= secondData - firstData;
                jumStok:= (StrToFloat(cbbJmlStok.Text) - result);
              end
              else if firstData > secondData then
              begin
                result:= firstData - secondData;
                jumStok:= (StrToFloat(cbbJmlStok.Text) + result);
              end;
                with DM.zBarang do
                begin
                Close;
                SQL.Clear;
                SQL.Add('update barang set qty_thn=:stok where kd_brg=:kode');
                ParamByName('kode').AsString := cbbKdBrg.Text;
                ParamByName('stok').AsString := FloatToStr(jumStok);
                ExecSQL;
                SQL.Clear;
                loadData;
                Open;
                with DM.zPenjualan do
                  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('update penjualan set jumlah_pbl=:jumlah where kd_pjl=:kode');
                    ParamByName('kode').AsString := edtKdPjl.Text;
                    ParamByName('jumlah').AsString := edtJumBeliUp.Text;
                    ExecSQL;
                    loadData;
                    Open;
                  end;
                end;
              end;
            ShowMessage('Data Berhasil Disimpan');
            setCancel;
            seleksiKategori;
          end;
        except
          ShowMessage('Data Gagal Disimpan');
        end;
      end;
  end;
end;

procedure TFormPenjualan.btnBatalClick(Sender: TObject);
begin
  setCancel;
  loadData;
  seleksiKategori;
end;

end.
