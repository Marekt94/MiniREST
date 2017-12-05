unit MiniRest.Attribute;

interface

uses MiniRest.Common, IdCustomHttpServer;

type
  RequestMappingAttribute = class(TCustomAttribute)
  private
    FMapping : string;
    FRequestMethod : TMiniRestRequestMethod;
    FPermission : string;
  public
    constructor Create(AMapping : string; APermission : string = ''; ARequestMethod : TMiniRestRequestMethod = rmGet); overload;
    constructor Create(AMapping : string; ARequestMethod : TMiniRestRequestMethod); overload;
    property Mapping : string read FMapping;
    property RequestMethod : TMiniRestRequestMethod read FRequestMethod;
    property Permission : string read FPermission;
  end;

  RequestMappingDesctriptionAttribute = class(TCustomAttribute)
  private
    FDescription: string;
  public
    constructor Create(ADescription: string);
    property Description: string read FDescription;
  end;

implementation

{ RequestMappingAttribute }

constructor RequestMappingAttribute.Create(AMapping: string; APermission : string;
  ARequestMethod: TMiniRestRequestMethod);
begin
  FMapping := AMapping;
  FRequestMethod := ARequestMethod;
  FPermission := APermission;
end;

constructor RequestMappingAttribute.Create(AMapping: string;
  ARequestMethod: TMiniRestRequestMethod);
begin
  Create(AMapping, '', ARequestMethod);
end;

{ RequestMappingDesctriptionAttribute }

constructor RequestMappingDesctriptionAttribute.Create(ADescription: string);
begin
  FDescription := ADescription;
end;

end.
