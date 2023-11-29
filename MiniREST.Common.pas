unit MiniREST.Common;

interface

uses System.Classes, IdContext, IdCustomHttpServer;

type
  TMiniRESTRequestMethod = (rmGet, rmPost, rmPut, rmDelete, rmOptions);
  //TMiniRESTAction = procedure(AContext: TIdContext;
  //ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo) of object;

  //TMiniRESTControllerBaseClass = class of TMiniRESTControllerBase;

  TMiniRESTResponseType = (rtTextHtml, rtApplicationJson);

  TMiniRESTServerType = (stIndy, stmORMot);

  TMiniRESTSameSite = (ssNone, ssLax, ssStrict);

  TMiniRESTCookie = class
  strict private
    FName : string;
    FValue : string;
    FExpires : TDateTime;
    FDomain : string;
    FPath : string;
    FSecure : boolean;
    FIP : string;
    FSameSite : TMiniRESTSameSite;

    FFieldList : TStrings;

    procedure AddFieldIfNotEmpty(AFieldName : string; const AFieldValue : string); overload;
    procedure AddFieldIfNotEmpty(AFieldName : string; const AFieldValue : TDateTime); overload;
    procedure AddFieldIfNotEmpty(const AFieldValue : TMiniRESTSameSite); overload;
    procedure AddSecure;
  public
    constructor Create(const AName: string; const AValue : string); reintroduce;
    destructor Destroy; override;
    function ToString : string;

    property Expires: TDateTime read FExpires write FExpires;
    property Domain: string read FDomain write FDomain;
    property Path: string read FPath write FPath;
    property Secure: boolean read FSecure write FSecure;
    property IP: string read FIP write FIP;
    property Samesite: TMiniRESTSameSite read FSamesite write FSamesite;
  end;

const
  MiniRESTResponseTypes : array[rtTextHtml..rtApplicationJson] of string =
  ('text/html',
  'application/json');

implementation

uses
  System.SysUtils;

const
  cCookieFieldWithValue = '%s=%s';

{ TMiniRESTCookie }

function TMiniRESTCookie.ToString: string;
var
  FFieldList : TStrings;
begin
  FFieldList.Clear;

  AddFieldIfNotEmpty(FName, FValue);
  AddFieldIfNotEmpty(FSameSite);
  AddFieldIfNotEmpty('expires', FExpires);   //do not localize
  AddFieldIfNotEmpty('domain', FDomain);     //do not localize
  AddFieldIfNotEmpty('ip', FIP);             //do not localize
  AddFieldIfNotEmpty('path', FPath);         //do not localize
  AddSecure;
end;

{ TMiniRESTCookie }

procedure TMiniRESTCookie.AddFieldIfNotEmpty(AFieldName: string;
  const AFieldValue: string);
begin
  if Trim(AFieldValue) <> '' then
    FFieldList.Add(Format(cCookieFieldWithValue, [AFieldName, AFieldValue]));
end;

procedure TMiniRESTCookie.AddFieldIfNotEmpty(AFieldName: string;
  const AFieldValue: TDateTime);
begin

end;

procedure TMiniRESTCookie.AddFieldIfNotEmpty(
  const AFieldValue: TMiniRESTSameSite);
const
  cSameSite = 'samesite';
begin
  case FSameSite of
    ssLax:    AddFieldIfNotEmpty(cSameSite, 'Lax');     //do not localize
    ssStrict: AddFieldIfNotEmpty(cSameSite, 'Strict');  //do not localize
  end;
end;

procedure TMiniRESTCookie.AddSecure;
begin
  if FSecure then
    FFieldList.Add('secure')  //do not localize
end;

constructor TMiniRESTCookie.Create(const AName, AValue: string);
begin
  inherited Create;
  FFieldList := TStringList.Create;
  FFieldList.Delimiter := ',';
  FName := AName;
  FValue := AValue;
end;

destructor TMiniRESTCookie.Destroy;
begin
  FFieldList.Free;
  inherited;
end;

end.
