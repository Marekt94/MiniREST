unit Test.SQL.SQLDb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, TestFramework;

type

  TTestCase1= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestHookUp;
  end;

implementation

procedure TTestCase1.TestHookUp;
begin
  Fail('Write your own test');
end;

procedure TTestCase1.SetUp;
begin

end;

procedure TTestCase1.TearDown;
begin

end;

initialization
  RegisterTest(TTestCase1.Suite);
end.

