cd ..\Tests
msbuild WebMocks.Tests.dproj /t:Build /p:Configuration=%WEBMOCK_CONFIG% /p:platform=%WEBMOCK_PLATFORM%
SET STATUS=%ERRORLEVEL%
echo C:\apps\BuildTools\Win32\GitHubStatusNotifier.exe -gitsha:%GITSHA% -successif:%STATUS% -context:%WEBMOCK_PLATFORM%,%WEBMOCK_CONFIG% -targeturl:https://build-artifacts.sempare.ltd/%GITHUB_OWNER%/%GITHUB_REPO%/%GITSHA%/dunitx-results.xml
C:\apps\BuildTools\Win32\GitHubStatusNotifier.exe -gitsha:%GITSHA% -successif:%STATUS% -context:%WEBMOCK_PLATFORM%,%WEBMOCK_CONFIG% -targeturl:https://build-artifacts.sempare.ltd/%GITHUB_OWNER%/%GITHUB_REPO%/%GITSHA%/dunitx-results.xml