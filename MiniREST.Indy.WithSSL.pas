unit MiniREST.Indy.WithSSL;

interface

uses
  MiniREST.Indy, IdGlobal;

type
  TMiniRESTServerIndyWithSSL = class(TMiniRESTServerIndy)
  public
    constructor Create(const ACertPath : string; const AKeyPath : string); reintroduce;
    procedure OnQuerySSLPort(APort: TIdPort; var AUseSSL: Boolean);
  end;

implementation

uses
  IdSSLOpenSSL;

{ TMiniRESTServerIndyWithSSL }

constructor TMiniRESTServerIndyWithSSL.Create(const ACertPath,
  AKeyPath: string);
var
  LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
begin
  inherited Create;

  LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(FHttpServer);
  LIOHandleSSL.SSLOptions.CertFile := ACertPath;
  LIOHandleSSL.SSLOptions.KeyFile := AKeyPath;
  LIOHandleSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];

  FHttpServer.IOHandler := LIOHandleSSL;
  FHttpServer.OnQuerySSLPort := OnQuerySSLPort;
end;

procedure TMiniRESTServerIndyWithSSL.OnQuerySSLPort(APort: TIdPort;
  var AUseSSL: Boolean);
begin
  AUseSSL := true;
end;

end.
