object DAOAtualizaCepEmLote: TDAOAtualizaCepEmLote
  OldCreateOrder = False
  Height = 254
  Width = 278
  object Client: TRESTClient
    BaseURL = 'http://localhost:8080/wk/rest/TSMAtualizaCepEmLote'
    Params = <>
    Left = 32
    Top = 8
  end
  object Request: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = Client
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body5DEC4AFD31CD4DCE83CA5239B5AC6BD4'
        Value = 
          '['#13#10'    {'#13#10'        "flnatureza": 2,'#13#10'        "dsdocumento": "2008' +
          '",'#13#10'        "nmprimeiro": "benjamim",'#13#10'        "nmsegundo": "men' +
          'des",'#13#10'        "dtregistro": "09/06/1979",'#13#10'        "dscep": "62' +
          '034070"'#13#10'    }'#13#10']'
        ContentType = ctAPPLICATION_JSON
      end>
    Resource = 'Atualizar/'
    Response = Response
    Left = 32
    Top = 56
  end
  object Response: TRESTResponse
    Left = 32
    Top = 112
  end
  object Adapter: TRESTResponseDataSetAdapter
    Dataset = DataSet
    FieldDefs = <>
    Response = Response
    Left = 32
    Top = 168
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 168
    Top = 80
  end
  object DataSet: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 168
    Top = 32
    object DataSetquantidade: TIntegerField
      FieldName = 'quantidade'
    end
  end
end
