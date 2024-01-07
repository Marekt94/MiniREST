unit MiniREST.Indy.WithSSL;

interface

uses
  MiniREST.Indy, IdGlobal, MiniREST.Server.Intf, IdSSLOpenSSL;

type
  TMiniRESTServerIndyWithSSL = class(TMiniRESTServerIndy, ISSL)
  strict private
    FIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
    FSecured : boolean;
    FCertPath : string;
    FKeyPath : string;
  public
    procedure SetCertPath(const ACertPath : string);
    procedure SetKeyPath(const AKeyPAth : string);
    function GetSecured : boolean;
    procedure SetSecured(const ASecured : boolean);
    procedure OnQuerySSLPort(APort: TIdPort; var AUseSSL: Boolean);
  end;

implementation

{ TMiniRESTServerIndyWithSSL }

function TMiniRESTServerIndyWithSSL.GetSecured: boolean;
begin
  Result := FSecured;
end;

procedure TMiniRESTServerIndyWithSSL.OnQuerySSLPort(APort: TIdPort;
  var AUseSSL: Boolean);
begin
  AUseSSL := FSecured;
end;

procedure TMiniRESTServerIndyWithSSL.SetCertPath(const ACertPath: string);
begin
  FCertPath := ACertPath;
  if Assigned(FIOHandleSSL) then
    FIOHandleSSL.SSLOptions.CertFile := FCertPath;
end;

procedure TMiniRESTServerIndyWithSSL.SetKeyPath(const AKeyPAth: string);
begin
  FKeyPath := AKeyPAth;
  if Assigned(FIOHandleSSL) then
    FIOHandleSSL.SSLOptions.KeyFile := FKeyPath;
end;

procedure TMiniRESTServerIndyWithSSL.SetSecured(const ASecured: boolean);
begin
  FSecured := ASecured;
  if FSecured then
  begin
    FIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(FHttpServer);
    FIOHandleSSL.SSLOptions.CertFile := FCertPath;
    FIOHandleSSL.SSLOptions.KeyFile := FKeyPath;
    FIOHandleSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

    FHttpServer.IOHandler := FIOHandleSSL;
    FHttpServer.OnQuerySSLPort := OnQuerySSLPort;
  end
  else
  begin
    FIOHandleSSL.Free;
    FHttpServer.IOHandler := nil;
  end;
end;

end.
