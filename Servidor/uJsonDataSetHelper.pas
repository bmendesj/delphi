unit uJsonDataSetHelper;

interface

uses
  System.Classes, System.SysUtils, System.NetEncoding, System.JSON,
  System.JSON.Writers, System.JSON.Types, Data.DB, REST.Json;

  Type
    TJsonDataSetHelper = class Helper for TDataSet
    public
      function ToJsonArray () : TJSonArray;
    end;

implementation

{ TDataSetHelper }

function TJsonDataSetHelper.ToJsonArray: TJSonArray;
var
  streamIn:       TStream;
  streamOut:      TStringStream;
  stringWriter:   TStringWriter;
  jsonTextWriter: TJsonTextWriter;
  cols:           integer;
begin
  stringWriter:= TStringWriter.Create;

  jsonTextWriter:= TJsonTextWriter.Create(stringWriter);
  jsonTextWriter.Formatting := TJsonFormatting.Indented;

  try
    Self.First;
    jsonTextWriter.WriteStartArray;

    while not Self.Eof do
      begin
        jsonTextWriter.WriteStartObject;

        for cols := 0 to Pred(FieldCount) do
        begin
          jsonTextWriter.WritePropertyName(Self.Fields[cols].FieldName);

          if Self.Fields[cols].IsNull then
            jsonTextWriter.WriteNull
          else
          begin
            case Fields[cols].DataType of
              ftBlob:
              begin
                streamIn:=  CreateBlobStream(Fields[cols], bmRead);
                streamOut:= TStringStream.Create;

                TNetEncoding.Base64.Encode(streamIn, streamOut);

                streamOut.Position:= 0;

                jsonTextWriter.WritePropertyName(Self.Fields[cols].FieldName);
                jsonTextWriter.WriteValue(streamOut.DataString);
              end;

              ftBoolean:
                jsonTextWriter.WriteValue(Fields[cols].AsBoolean);

              ftFloat, ftExtended, ftFMTBcd, ftBCD:
                jsonTextWriter.WriteValue(Fields[cols].AsFloat);

              ftCurrency:
                jsonTextWriter.WriteValue(Fields[cols].AsCurrency);

              ftSmallint, ftShortint, ftWord, ftInteger, ftAutoInc,

              ftLargeint, ftLongWord:
                jsonTextWriter.WriteValue(Int64(Fields[cols].Value));

              ftString, ftFmtMemo, ftMemo, ftWideString, ftWideMemo, ftUnknown :
                jsonTextWriter.WriteValue(Trim(Fields[cols].Value));

              ftDateTime:
                jsonTextWriter.WriteValue(FormatDatetime('DD/MM/YYYY hh:nn:ss', Self.Fields[cols].AsDateTime));

              ftDate:
                jsonTextWriter.WriteValue(FormatDatetime('DD/MM/YYYY', Self.fields[cols].AsDateTime));

              ftTime, ftTimeStamp:
                jsonTextWriter.WriteValue(FormatDatetime('hh:hh:ss', Self.Fields[cols].AsDateTime));

              ftBytes:
                jsonTextWriter.WriteValue(Self.Fields[cols].AsBytes);
            end;
          end;
        end;

        jsonTextWriter.WriteEndObject;
        Self.Next;
      end;

    jsonTextWriter.WriteEndArray;

    Result:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(stringWriter.ToString), 0) as TJSONArray;
  finally
    if stringWriter <> nil then
      FreeAndNil(stringWriter);

    if jsonTextWriter <> nil then
      FreeAndNil(jsonTextWriter);
  end;
end;

end.
