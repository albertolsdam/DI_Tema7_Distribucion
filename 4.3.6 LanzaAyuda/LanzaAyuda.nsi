;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------

;Variables

  Var StartMenuFolder

;--------------------------------
;General

  ;Name and file
  Name "LanzaAyuda"
  OutFile "InstallAyuda.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$PROGRAMFILES\LanzaAyuda"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\LanzaAyuda" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------


;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\LanzaAyuda"
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------

;--------------------------------
;Installer Sections

Section "Instalar Lanza Ayuda" SecLanzaAyuda

  SetOutPath $INSTDIR

  File LanzaAyuda.7z

	Nsis7z::ExtractWithDetails "$INSTDIR\LanzaAyuda.7z" "Instalando..."
	Delete "$OUTDIR\LanzaAyuda.7z"

  ;Store installation folder
  WriteRegStr HKCU "Software\LanzaAyuda" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallLanzaAyuda.exe"


  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application

    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortcut "$SMPROGRAMS\$StartMenuFolder\LanzaAyuda.lnk" "$INSTDIR\LanzaAyuda.jar"
    CreateShortcut "$SMPROGRAMS\$StartMenuFolder\UninstallLanzaAyuda.lnk" "$INSTDIR\UninstallLanzaAyuda.exe"

  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

;--------------------------------

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\UninstallLanzaAyuda.exe"

  RMDir /r "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder

  Delete "$SMPROGRAMS\$StartMenuFolder\UninstallLanzaAyuda.lnk"
  Delete "$SMPROGRAMS\$StartMenuFolder\LanzaAyuda.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey /ifempty HKCU "Software\LanzaAyuda"

SectionEnd
