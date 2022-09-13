object DAOViaCep: TDAOViaCep
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
        Name = 'cep'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'logradouro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'complemento'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'localidade'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'uf'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ibge'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'gia'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ddd'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'siafi'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 200
    Top = 8
    object DataSetcep: TStringField
      FieldName = 'cep'
      Size = 15
    end
    object DataSetlogradouro: TStringField
      FieldName = 'logradouro'
      Size = 100
    end
    object DataSetcomplemento: TStringField
      FieldName = 'complemento'
      Size = 100
    end
    object DataSetbairro: TStringField
      FieldName = 'bairro'
      Size = 100
    end
    object DataSetlocalidade: TStringField
      FieldName = 'localidade'
      Size = 100
    end
    object DataSetuf: TStringField
      FieldName = 'uf'
      Size = 50
    end
    object DataSetibge: TStringField
      FieldName = 'ibge'
      Size = 10
    end
    object DataSetgia: TStringField
      FieldName = 'gia'
      Size = 10
    end
    object DataSetddd: TStringField
      FieldName = 'ddd'
      Size = 2
    end
    object DataSetsiafi: TStringField
      FieldName = 'siafi'
      Size = 10
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 200
    Top = 56
  end
  object Client: TRESTClient
    BaseURL = 'http://localhost:8080/wk/rest/TSMViaCep'
    Params = <>
    Left = 64
  end
  object Request: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = Client
    Params = <
      item
        Kind = pkQUERY
        Name = 'qCep'
        Value = '62034070'
      end
      item
        Kind = pkREQUESTBODY
        Name = 'bodyC64C22B1865A4007BA072258FDC80C92'
        Value = 
          '['#13#10'    {'#13#10'        "flnatureza": 2,'#13#10'        "dsdocumento": "2008' +
          '",'#13#10'        "nmprimeiro": "benjamim",'#13#10'        "nmsegundo": "men' +
          'des",'#13#10'        "dtregistro": "09/06/1979",'#13#10'        "dscep": "62' +
          '034070"'#13#10'    }'#13#10']'
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'consultacep'
    Response = Response
    Left = 64
    Top = 48
  end
  object Response: TRESTResponse
    Left = 64
    Top = 96
  end
end
