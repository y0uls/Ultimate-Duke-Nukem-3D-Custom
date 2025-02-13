; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Ultimate Duke Nukem 3D Custom"
#define MyAppVersion "1.0"
#define MyAppPublisher "Ultimate Duke Nukem 3D Custom By Y0uls"
#define MyAppExeName "Ultimate Duke Nukem 3D Custom.bat"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{607C781D-E9BE-4203-AE25-9EFFB22933D9}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DisableDirPage=no
DisableWelcomePage=no
UserInfoPage=no
DisableProgramGroupPage=yes
OutputDir=C:\Inno Setup Output\UDNC
OutputBaseFilename=UltimateDukeNukemInstaller
WizardImageFile=DukeNukem3D.bmp
SetupIconFile=duke.ico
UninstallDisplayIcon={app}\duke.ico
DiskSpanning=yes
DiskSliceSize=1200000000
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
Password=UDNC
Encryption=yes
PrivilegesRequired=admin

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "fr"; MessagesFile: "compiler:Languages\French.isl"

[Dirs]
Name: "{app}"; Permissions: users-full

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "readme"; Description: "Read Me"; GroupDescription: "Options"; Flags: unchecked

[Files]
Source: "duke.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "Ultimate Duke Nukem 3D Custom.zip"; DestDir: "{app}"; Flags: ignoreversion; AfterInstall: DecompressAndDeleteZip


[Icons]
Name: "{autodesktop}\Ultimate Duke Nukem 3D Custom"; Filename:"{app}\{#MyAppExeName}"; IconFilename:"{app}\duke.ico"; Tasks: desktopicon;

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Ultimate Duke Nukem 3D Custom"; Flags: shellexec postinstall runhidden
Filename: "{app}\ReadMe.txt"; Description: "Read Me"; Flags: postinstall shellexec skipifsilent; Tasks: readme

[UninstallDelete]
Type: files; Name: "{app}\*.*"
Type: filesandordirs; Name: "{app}\*"

[Code]
procedure DecompressAndDeleteZip;
var
  ShellApp: Variant;
  ZipFilePath, ExtractPath: string;
begin
  ZipFilePath := ExpandConstant('{app}\Ultimate Duke Nukem 3D Custom.zip');
  ExtractPath := ExpandConstant('{app}');
  
  try
    ShellApp := CreateOleObject('Shell.Application');
  except
    MsgBox('Erreur lors de la création de l''objet Shell.Application', mbError, MB_OK);
    Exit;
  end;

  if VarIsNull(ShellApp) then
  begin
    Exit;
  end;

  if not FileExists(ZipFilePath) then
  begin
    Exit;
  end;

  try
    ShellApp.NameSpace(ExtractPath).CopyHere(ShellApp.NameSpace(ZipFilePath).Items, 16);
    DeleteFile(ZipFilePath);
  except
    MsgBox('Erreur lors de la décompression du fichier ZIP', mbError, MB_OK);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    DecompressAndDeleteZip;
  end;
end;