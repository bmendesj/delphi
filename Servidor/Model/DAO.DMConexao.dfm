object DMConexao: TDMConexao
  OldCreateOrder = False
  Height = 139
  Width = 126
  object FDPostgre: TFDConnection
    Params.Strings = (
      'Database=wk'
      'User_Name=postgres'
      'Password=root'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 40
    Top = 8
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 40
    Top = 56
  end
end
