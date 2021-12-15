object DM: TDM
  OldCreateOrder = False
  Left = 239
  Top = 120
  Height = 446
  Width = 311
  object zcon: TZConnection
    ControlsCodePage = cCP_UTF8
    AutoEncodeStrings = False
    Properties.Strings = (
      'controls_cp=CP_UTF8')
    Connected = True
    HostName = '127.0.0.1'
    Port = 3306
    Database = 'db_5n_v3'
    User = 'root'
    Protocol = 'mysql'
    LibraryLocation = 
      'E:\Folder A\Pemrograman Visual 3\Aplikasi Toko Komputer By M40U ' +
      'v.0.0.1\libmysql.dll'
    Left = 16
    Top = 16
  end
  object zAdmin: TZQuery
    Connection = zcon
    Active = True
    SQL.Strings = (
      'select * from admin')
    Params = <>
    Left = 16
    Top = 64
  end
  object zKategori: TZQuery
    Connection = zcon
    Active = True
    SQL.Strings = (
      'select * from kategori')
    Params = <>
    Left = 112
    Top = 64
    object strngfldKategorikd_kat: TStringField
      FieldName = 'kd_kat'
      Required = True
      Size = 72
    end
    object strngfldKategorinm_kat: TStringField
      FieldName = 'nm_kat'
      Required = True
      Size = 100
    end
    object dtfldKategoritgl_kat: TDateField
      FieldName = 'tgl_kat'
      ReadOnly = True
      DisplayFormat = 'dd mmmm yyyy'
    end
  end
  object zSuplier: TZQuery
    Connection = zcon
    Active = True
    SQL.Strings = (
      'select * from suplier')
    Params = <>
    Left = 160
    Top = 64
  end
  object zPenjualan: TZQuery
    Connection = zcon
    Active = True
    SQL.Strings = (
      'select * from penjualan')
    Params = <>
    Left = 216
    Top = 64
  end
  object dsAdmin: TDataSource
    DataSet = zAdmin
    Left = 16
    Top = 136
  end
  object dsBarang: TDataSource
    DataSet = zBarang
    Left = 64
    Top = 136
  end
  object dsKategori: TDataSource
    DataSet = zKategori
    Left = 112
    Top = 136
  end
  object dsSuplier: TDataSource
    DataSet = zSuplier
    Left = 216
    Top = 136
  end
  object dsPenjualan: TDataSource
    DataSet = zPenjualan
    Left = 160
    Top = 136
  end
  object prntdbKat: TPrintDBGridEh
    DBGridEh = FormKategori.dbgrdKat
    Options = [pghFitGridToPageWidth, pghColored, pghRowAutoStretch]
    Page.BottomMargin = 4.000000000000000000
    Page.LeftMargin = 4.000000000000000000
    Page.RightMargin = 3.000000000000000000
    Page.TopMargin = 4.000000000000000000
    PageFooter.Font.Charset = ANSI_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -15
    PageFooter.Font.Name = 'Times New Roman'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      '')
    PageHeader.Font.Charset = ANSI_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -15
    PageHeader.Font.Name = 'Times New Roman'
    PageHeader.Font.Style = [fsBold]
    Title.Strings = (
      'Kategori Barang')
    Units = MM
    Left = 16
    Top = 192
  end
  object pm1: TPopupMenu
    Left = 64
    Top = 16
    object mniHapus1: TMenuItem
      Caption = 'Hapus'
      OnClick = mniHapus1Click
    end
    object mniCetak1: TMenuItem
      Caption = 'Cetak'
      OnClick = mniCetak1Click
    end
  end
  object prntdbSuplier: TPrintDBGridEh
    DBGridEh = FormSuplier.dbgrdSuplier
    Options = [pghFitGridToPageWidth, pghColored, pghRowAutoStretch]
    Page.BottomMargin = 4.000000000000000000
    Page.LeftMargin = 4.000000000000000000
    Page.RightMargin = 3.000000000000000000
    Page.TopMargin = 4.000000000000000000
    PageFooter.Font.Charset = ANSI_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -15
    PageFooter.Font.Name = 'Times New Roman'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      '')
    PageHeader.Font.Charset = ANSI_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -15
    PageHeader.Font.Name = 'Times New Roman'
    PageHeader.Font.Style = [fsBold]
    Title.Strings = (
      'Daftar Suplier')
    Units = MM
    Left = 64
    Top = 192
  end
  object zBarang: TZQuery
    Connection = zcon
    Active = True
    SQL.Strings = (
      'select * from barang')
    Params = <>
    Left = 64
    Top = 64
  end
  object prntdbBrg: TPrintDBGridEh
    DBGridEh = FormBarang.dbgrdBrg
    Options = [pghFitGridToPageWidth, pghColored, pghRowAutoStretch]
    Page.BottomMargin = 4.000000000000000000
    Page.LeftMargin = 4.000000000000000000
    Page.RightMargin = 3.000000000000000000
    Page.TopMargin = 4.000000000000000000
    PageFooter.Font.Charset = ANSI_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -15
    PageFooter.Font.Name = 'Times New Roman'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      '')
    PageHeader.Font.Charset = ANSI_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -15
    PageHeader.Font.Name = 'Times New Roman'
    PageHeader.Font.Style = [fsBold]
    Title.Strings = (
      'Daftar Barang')
    Units = MM
    Left = 112
    Top = 192
  end
  object prntdbPjl: TPrintDBGridEh
    DBGridEh = FormPenjualan.dbgrdPjl
    Options = [pghFitGridToPageWidth, pghColored, pghRowAutoStretch]
    Page.BottomMargin = 4.000000000000000000
    Page.LeftMargin = 4.000000000000000000
    Page.RightMargin = 3.000000000000000000
    Page.TopMargin = 4.000000000000000000
    PageFooter.Font.Charset = ANSI_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -15
    PageFooter.Font.Name = 'Times New Roman'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      '')
    PageHeader.Font.Charset = ANSI_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -15
    PageHeader.Font.Name = 'Times New Roman'
    PageHeader.Font.Style = [fsBold]
    Title.Strings = (
      'Daftar Penjualan')
    Units = MM
    Left = 160
    Top = 192
  end
  object prntdbUser: TPrintDBGridEh
    DBGridEh = FormUser.dbgrdUser
    Options = [pghFitGridToPageWidth, pghColored, pghRowAutoStretch]
    Page.BottomMargin = 4.000000000000000000
    Page.LeftMargin = 4.000000000000000000
    Page.RightMargin = 3.000000000000000000
    Page.TopMargin = 4.000000000000000000
    PageFooter.Font.Charset = ANSI_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -15
    PageFooter.Font.Name = 'Times New Roman'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      '')
    PageHeader.Font.Charset = ANSI_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -15
    PageHeader.Font.Name = 'Times New Roman'
    PageHeader.Font.Style = [fsBold]
    Title.Strings = (
      'Daftar User')
    Units = MM
    Left = 200
    Top = 192
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 16
    Top = 256
  end
  object tmr3: TTimer
    Enabled = False
    OnTimer = tmr3Timer
    Left = 112
    Top = 256
  end
  object tmr4: TTimer
    Enabled = False
    OnTimer = tmr4Timer
    Left = 160
    Top = 256
  end
  object tmr2: TTimer
    Enabled = False
    OnTimer = tmr2Timer
    Left = 64
    Top = 256
  end
  object NotaPenjualan: TfrxReport
    Version = '4.12.6'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44515.474461423600000000
    ReportOptions.LastChange = 44529.600571736100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 16
    Top = 320
    Datasets = <
      item
        DataSet = FormLap_Penjualan.frxdbdtst1
        DataSetName = 'frxDBDataset1'
      end
      item
        DataSet = FormLap_User.frxdbdtst1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 335.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object ReportTitle1: TfrxReportTitle
        Height = 154.241496670000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = NotaPenjualan.Child1
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 246.590910000000000000
          Top = 18.447948880000000000
          Width = 238.110390000000000000
          Height = 34.015770000000000000
          ShowHint = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'Toko M40U ComTech')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 99.555555560000000000
          Top = 61.102350000000000000
          Width = 707.821583330000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8 = (
            
              'Jalan Ujung Lintas Dalam Pemurus Lama No.56 RT 36 RW 09 BanjarTi' +
              'mur, Banjarmasin')
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 52.732220010000000000
        Top = 253.228510000000000000
        Width = 718.110700000000000000
        object Memo34: TfrxMemoView
          Left = 245.111111100000000000
          Top = 11.716450010000000000
          Width = 238.110390000000000000
          Height = 34.015770000000000000
          ShowHint = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'Laporan Daftar User')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        Height = 32.010513340000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        object Line1: TfrxLineView
          Left = 0.222222210000000000
          Top = 14.160894440000000000
          Width = 716.666666680000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        Height = 42.677180000000000000
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        DataSet = FormLap_User.frxdbdtst1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object Memo2: TfrxMemoView
          Left = 84.250000000000000000
          Top = 10.635590000000000000
          Width = 176.750000000000000000
          Height = 18.000000000000000000
          ShowHint = False
          Memo.UTF8 = (
            '[frxDBDataset1."kd_pjl"]')
        end
      end
    end
  end
  object tmr5: TTimer
    Enabled = False
    OnTimer = tmr5Timer
    Left = 208
    Top = 256
  end
  object tmr6: TTimer
    Enabled = False
    OnTimer = tmr6Timer
    Left = 256
    Top = 256
  end
end
