object DAOPessoas: TDAOPessoas
  OldCreateOrder = False
  Height = 217
  Width = 262
  object Adapter: TRESTResponseDataSetAdapter
    Active = True
    Dataset = DataSet
    FieldDefs = <>
    Response = Response
    Left = 64
    Top = 144
  end
  object DataSet: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'idpessoa'
        DataType = ftLargeint
      end
      item
        Name = 'flnatureza'
        DataType = ftSmallint
      end
      item
        Name = 'dsdocumento'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nmprimeiro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'nmsegundo'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'dtregistro'
        DataType = ftDate
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 200
    Top = 8
    object DataSetidpessoa: TLargeintField
      DisplayLabel = 'ID'
      FieldName = 'idpessoa'
    end
    object DataSetflnatureza: TSmallintField
      DisplayLabel = 'Natureza'
      FieldName = 'flnatureza'
    end
    object DataSetdsdocumento: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'dsdocumento'
    end
    object DataSetnmprimeiro: TStringField
      DisplayLabel = 'Primeiro nome'
      DisplayWidth = 30
      FieldName = 'nmprimeiro'
      Size = 100
    end
    object DataSetnmsegundo: TStringField
      DisplayLabel = 'Segundo Nome'
      DisplayWidth = 30
      FieldName = 'nmsegundo'
      Size = 100
    end
    object DataSetdtregistro: TDateField
      DisplayLabel = 'Dt. Registro'
      FieldName = 'dtregistro'
      EditMask = '!99/99/0000;1;_'
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 200
    Top = 56
  end
  object Client: TRESTClient
    BaseURL = 'http://localhost:8080/wk/rest/TSMPessoa'
    Params = <>
    Left = 64
  end
  object Request: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = Client
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'bodyC6C2ED7E80C849F99DBCC7BDB525B6AF'
        Value = 
          '['#13#10'    {'#13#10'        "flnatureza": 2,'#13#10'        "dsdocumento": "2008' +
          '",'#13#10'        "nmprimeiro": "benjamim",'#13#10'        "nmsegundo": "men' +
          'des",'#13#10'        "dtregistro": "09/06/1979",'#13#10'        "dscep": "62' +
          '034070"'#13#10'    }'#13#10']'
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'pessoas'
    Response = Response
    Left = 64
    Top = 48
  end
  object Response: TRESTResponse
    Left = 64
    Top = 96
  end
end
