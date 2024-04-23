unit MiniREST.Indy.WithSSL;

interface

uses
  MiniREST.Indy, IdGlobal, MiniREST.Server.Intf, IdOpenSSLIOHandlerServer, IdOpenSSLVersion;

type
  TMiniRESTServerIndyWithSSL = class(TMiniRESTServerIndy, ISSL)
  strict private
    FIOHandleSSL: TIdOpenSSLIOHandlerServer;
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
    FIOHandleSSL.Options.CertFile := FCertPath;
end;

procedure TMiniRESTServerIndyWithSSL.SetKeyPath(const AKeyPAth: string);
begin
  FKeyPath := AKeyPAth;
  if Assigned(FIOHandleSSL) then
    FIOHandleSSL.Options.CertKey := FKeyPath;
end;

procedure TMiniRESTServerIndyWithSSL.SetSecured(const ASecured: boolean);
begin
  FSecured := ASecured;
  if FSecured then
  begin
    FIOHandleSSL := TIdOpenSSLIOHandlerServer.Create(FHttpServer);
    FIOHandleSSL.Options.CertFile := FCertPath;
    FIOHandleSSL.Options.CertKey := FKeyPath;
    FIOHandleSSL.Options.TLSVersionMinimum := TIdOpenSSLVersion.TLSv1_2;
    FIOHandleSSL.Options.TLSVersionMaximum := TIdOpenSSLVersion.TLSv1_3;

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
