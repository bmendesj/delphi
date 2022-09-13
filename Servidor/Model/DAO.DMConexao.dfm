object DMConexao: TDMConexao
  OldCreateOrder = False
  Height = 235
  Width = 444
  object FDPostgre: TFDConnection
    Params.Strings = (
      'Database=wk'
      'User_Name=postgres'
      'Password=root'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 8
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 40
    Top = 56
  end
  object fdqPessoa: TFDQuery
    Active = True
    Connection = FDPostgre
    UpdateOptions.AutoIncFields = 'idpessoa'
    SQL.Strings = (
      'SELECT * FROM teste_delphi.pessoa')
    Left = 144
  end
  object fdqEndereco: TFDQuery
    Connection = FDPostgre
    UpdateOptions.AutoIncFields = 'idpessoa'
    SQL.Strings = (
      'SELECT * FROM teste_delphi.pessoa')
    Left = 144
    Top = 56
  end
end
