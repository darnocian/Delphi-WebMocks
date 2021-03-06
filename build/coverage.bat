cd ..\Tests
if exist reports (
rmdir /S /Q reports
)
mkdir reports
C:\Apps\BuildTools\Win32\CodeCoverage.exe -e WebMocks.Tests.exe -m WebMocks.Tests.map -esm ..\* -ife -xml -xmllines -html -uf coverage_units.lst -od reports\coverage -dproj WebMocks.Tests.dproj -lt reports\CodeCoverage.log
C:\Apps\BuildTools\Win32\GitHubCodeCovStatusNotifier.exe -context:%WEBMOCK_PLATFORM%,%WEBMOCK_CONFIG% -coverage:reports\CodeCoverage.log -gitsha:%GITSHA%