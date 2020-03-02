;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------

;Variables

  Var StartMenuFolder

;--------------------------------
;General

  ;Name and file
  Name "App Hotel Curtiss"
  OutFile "AppHotelCurtiss.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$PROGRAMFILES\AppHotelCurtiss"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\AppHotelCurtiss" ""

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
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\AppHotelCurtiss"
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

Section "Instalar App Hotel Curtiss" SecLanzaAyuda

  SetOutPath $INSTDIR

  File AppHotelCurtiss.7z

	Nsis7z::ExtractWithDetails "$INSTDIR\AppHotelCurtiss.7z" "Descromprimiendo archivos..."
	Delete "$OUTDIR\AppHotelCurtiss.7z"

  ;Store installation folder
  WriteRegStr HKCU "Software\AppHotelCurtiss" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallAppHotelCurtiss.exe"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application

    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortcut "$SMPROGRAMS\$StartMenuFolder\AppHotelCurtiss.lnk" "$INSTDIR\DI_T2_AppHotel.jar"
    CreateShortcut "$SMPROGRAMS\$StartMenuFolder\UninstallAppHotelCurtiss.lnk" "$INSTDIR\UninstallAppHotelCurtiss.exe"

  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

;--------------------------------

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\UninstallAppHotelCurtiss.exe"

  RMDir /r "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder

  Delete "$SMPROGRAMS\$StartMenuFolder\UninstallAppHotelCurtiss.lnk"
  Delete "$SMPROGRAMS\$StartMenuFolder\AppHotelCurtiss.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"

  DeleteRegKey /ifempty HKCU "Software\AppHotelCurtiss"

SectionEnd
