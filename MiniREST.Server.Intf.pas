unit MiniREST.Server.Intf;

interface

uses SysUtils, MiniREST.Controller.Intf, {MiniREST.Controller.Base,}
  MiniREST.Controller.Security.Intf, MiniREST.Intf;

type
  ISSL = interface
    ['{B707B0D3-D358-4CFA-B4B2-DEB66D136E4E}']
    procedure SetCertPath(const ACertPath : string);
    procedure SetKeyPath(const AKeyPAth : string);
    function GetSecured : boolean;
    procedure SetSecured(const ASecured : boolean);
    property CertPath : string write SetCertPath;
    property KeyPath  : string write SetKeyPath;
    property Secured  : boolean read GetSecured write SetSecured;
  end;

  IMiniRESTServer = interface
  ['{91170691-E5BF-4C74-9B7F-052908DDA8E7}']
    procedure AddController(AController : TClass); overload;
    procedure AddController(AControllerFactory : IMiniRESTControllerFactory); overload;
    procedure SetControllerOtherwise(AController : TClass);
    procedure SetSecurityController(AController : TFunc<IMiniRESTSecurityController>);
    function GetLogger : IMiniRESTLogger;
    procedure SetLogger(ALogger : IMiniRESTLogger);
    procedure AddMiddleware(AMiddleware : IMiniRESTMiddleware); { TODO : Mudar para class ou factory ?}
    function GetPort : Integer;
    procedure SetPort(APort : Integer);
    function Start : Boolean;
    function Stop : Boolean;
  end;

implementation

end.
