program AplikasiTokoKomputerByM40U;

uses
  Forms,
  login in 'login.pas' {FormLogin},
  menu in 'menu.pas' {FormMenu},
  datamodul in 'datamodul.pas' {DM: TDataModule},
  kontroluser in 'kontroluser.pas' {FormUser},
  kategori in 'kategori.pas' {FormKategori},
  barang in 'barang.pas' {FormBarang},
  suplier in 'suplier.pas' {FormSuplier},
  penjualan in 'penjualan.pas' {FormPenjualan},
  Lap_Barang in 'C:\Program Files (x86)\Borland\FastReport 4\LibD7\Lap_Barang.pas' {FormLap_Barang},
  search_date in 'search_date.pas' {FormSearchDate},
  Lap_User in 'Lap_User.pas' {FormLap_User},
  Lap_Penjualan in 'Lap_Penjualan.pas' {FormLap_Penjualan};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMenu, FormMenu);
  Application.CreateForm(TFormPenjualan, FormPenjualan);
  Application.CreateForm(TFormBarang, FormBarang);
  Application.CreateForm(TFormSuplier, FormSuplier);
  Application.CreateForm(TFormKategori, FormKategori);
  Application.CreateForm(TFormUser, FormUser);
  Application.CreateForm(TFormLap_User, FormLap_User);
  Application.CreateForm(TFormLap_Penjualan, FormLap_Penjualan);
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormLap_Barang, FormLap_Barang);
  Application.CreateForm(TFormSearchDate, FormSearchDate);
  Application.Run;
end.
