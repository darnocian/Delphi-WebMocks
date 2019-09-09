program Delphi.WebMocks.Tests;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  Delphi.WebMock.Tests in 'Delphi.WebMock.Tests.pas',
  Delphi.WebMock in '..\Delphi.WebMock.pas',
  TestHelpers in 'TestHelpers.pas',
  Delphi.WebMock.RequestStub.Tests in 'Delphi.WebMock.RequestStub.Tests.pas',
  Delphi.WebMock.RequestStub in '..\Delphi.WebMock.RequestStub.pas',
  Delphi.WebMock.Indy.RequestMatcher.Tests in 'Delphi.WebMock.Indy.RequestMatcher.Tests.pas',
  Delphi.WebMock.Indy.RequestMatcher in '..\Delphi.WebMock.Indy.RequestMatcher.pas',
  Mock.Indy.HTTPRequestInfo in 'Mock.Indy.HTTPRequestInfo.pas',
  Delphi.WebMock.ResponseStatus.Tests in 'Delphi.WebMock.ResponseStatus.Tests.pas',
  Delphi.WebMock.ResponseStatus in '..\Delphi.WebMock.ResponseStatus.pas',
  Delphi.WebMock.Response.Tests in 'Delphi.WebMock.Response.Tests.pas',
  Delphi.WebMock.Response in '..\Delphi.WebMock.Response.pas',
  Delphi.WebMock.ResponseContentString.Tests in 'Delphi.WebMock.ResponseContentString.Tests.pas',
  Delphi.WebMock.ResponseContentString in '..\Delphi.WebMock.ResponseContentString.pas',
  Delphi.WebMock.ResponseContentSource in '..\Delphi.WebMock.ResponseContentSource.pas',
  Delphi.WebMock.Tests.Client in 'Delphi.WebMock.Tests.Client.pas',
  Delphi.WebMock.ResponseContentFile.Tests in 'Delphi.WebMock.ResponseContentFile.Tests.pas',
  Delphi.WebMock.ResponseContentFile in '..\Delphi.WebMock.ResponseContentFile.pas',
  Delphi.WebMock.Matching.Tests in 'Features\Delphi.WebMock.Matching.Tests.pas',
  Delphi.WebMock.StringWildcardMatcher.Tests in 'Delphi.WebMock.StringWildcardMatcher.Tests.pas',
  Delphi.WebMock.StringWildcardMatcher in '..\Delphi.WebMock.StringWildcardMatcher.pas',
  Delphi.WebMock.StringMatcher in '..\Delphi.WebMock.StringMatcher.pas',
  Delphi.WebMock.StringRegExMatcher.Tests in 'Delphi.WebMock.StringRegExMatcher.Tests.pas',
  Delphi.WebMock.StringRegExMatcher in '..\Delphi.WebMock.StringRegExMatcher.pas',
  Delphi.WebMock.ResponsesWithHeaders.Tests in 'Features\Delphi.WebMock.ResponsesWithHeaders.Tests.pas',
  Delphi.WebMock.ResponsesWithContent.Tests in 'Features\Delphi.WebMock.ResponsesWithContent.Tests.pas',
  Delphi.WebMock.MatchingContent.Tests in 'Features\Delphi.WebMock.MatchingContent.Tests.pas',
  Delphi.WebMock.StringAnyMatcher.Tests in 'Delphi.WebMock.StringAnyMatcher.Tests.pas',
  Delphi.WebMock.StringAnyMatcher in '..\Delphi.WebMock.StringAnyMatcher.pas';

var
  Runner: ITestRunner;
  Results: IRunResults;
  Logger: ITestLogger;
  NUnitLogger: ITestLogger;

begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    // Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    // Create the test runner
    Runner := TDUnitX.CreateRunner;
    // Tell the runner to use RTTI to find Fixtures
    Runner.UseRTTI := True;
    // tell the runner how we will log things
    // Log to the console window
    Logger := TDUnitXConsoleLogger.Create(True);
    Runner.AddLogger(Logger);
    // Generate an NUnit compatible XML File
    NUnitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    Runner.AddLogger(NUnitLogger);
    Runner.FailsOnNoAsserts := False;
    // When true, Assertions must be made during tests;

    // Run tests
    Results := Runner.Execute;
    if not Results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

{$IFNDEF CI}
    // We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
{$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;

end.
