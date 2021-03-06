cd ..\Tests
WebMocks.Tests.exe -exit:Continue -b
C:\apps\BuildTools\Win32\GithubTestStatusNotifier.exe -gitsha:%GITSHA% -context:%WEBMOCK_PLATFORM%,%WEBMOCK_CONFIG% -dunitx:%CHECKOUT_DIR%\Tests\dunitx-results.xml  -targeturl:https://build-artifacts.sempare.ltd/%GITHUB_OWNER%/%GITHUB_REPO%/%GITSHA%/coverage/coverage.html