object DAOEnderecos: TDAOEnderecos
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
        Name = 'idendereco'
        DataType = ftLargeint
      end
      item
        Name = 'idpessoa'
        DataType = ftLargeint
      end
      item
        Name = 'dscep'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'dsuf'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'nmcidade'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'nmbairro'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'nmlogradouro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'dscomplemento'
        DataType = ftString
        Size = 100
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
    object DataSetidendereco: TLargeintField
      FieldName = 'idendereco'
      Visible = False
    end
    object DataSetidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Visible = False
    end
    object DataSetdscep: TStringField
      DisplayLabel = 'CEP'
      DisplayWidth = 8
      FieldName = 'dscep'
      Size = 15
    end
    object DataSetdsuf: TStringField
      DisplayLabel = 'Estado'
      DisplayWidth = 30
      FieldName = 'dsuf'
      Size = 50
    end
    object DataSetnmcidade: TStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 30
      FieldName = 'nmcidade'
      Size = 100
    end
    object DataSetnmbairro: TStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 30
      FieldName = 'nmbairro'
      Size = 50
    end
    object DataSetnmlogradouro: TStringField
      DisplayLabel = 'Logradouro'
      DisplayWidth = 30
      FieldName = 'nmlogradouro'
      Size = 100
    end
    object DataSetdscomplemento: TStringField
      DisplayLabel = 'Complemento'
      DisplayWidth = 30
      FieldName = 'dscomplemento'
      Size = 100
    end
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 200
    Top = 56
  end
  object Client: TRESTClient
    BaseURL = 'http://localhost:8080/wk/rest/TSMEndereco'
    Params = <>
    Left = 64
  end
  object Request: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = Client
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body7DDDF5DC347441FCA4668F4AF50A7B84'
        Value = 
          '['#13#10'    {'#13#10'        "flnatureza": 2,'#13#10'        "dsdocumento": "2008' +
          '",'#13#10'        "nmprimeiro": "benjamim",'#13#10'        "nmsegundo": "men' +
          'des",'#13#10'        "dtregistro": "09/06/1979",'#13#10'        "dscep": "62' +
          '034070"'#13#10'    }'#13#10']'
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'enderecos'
    Response = Response
    Left = 64
    Top = 48
  end
  object Response: TRESTResponse
    Left = 64
    Top = 96
  end
end
