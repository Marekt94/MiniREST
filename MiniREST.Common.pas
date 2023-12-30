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
  public
    constructor Create(const AName: string; const AValue : string); reintroduce;

    property Name: string read FName;
    property Value: string read FValue;
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

{ TMiniRESTCookie }


constructor TMiniRESTCookie.Create(const AName, AValue: string);
begin
  inherited Create;
  FName := AName;
  FValue := AValue;
end;

end.
