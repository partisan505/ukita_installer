;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  !include "x64.nsh"
  !include "LogicLib.nsh"
  !include "FileFunc.nsh"
  !include "WinVer.nsh"
;--------------------------------
;General

!packhdr tmpexe.tmp "UPX --best -f -q -v --ultra-brute --all-methods --all-filters --compress-icons=0 tmpexe.tmp" ;upx

  Unicode true
  ManifestDPIAware true

  
  SetCompressor /SOLID lzma
  SetCompressorDictSize 128
  SetDatablockOptimize ON

  ;Define name of the product
  !define PRODUCT "UkITA Installer"
  !define PRODUCT_VERSION "2.0.9"
  !define INSTALLER_NAME "ukita_installer"
  !define UNINSTALLER_NAME "uninstall"
  
  !define telegram_link "https://t.me/itarmyofukraine2022"
  
  !define discord_link "https://discord.gg/DBYFvGQypD"
  
  BrandingText "${PRODUCT} ${PRODUCT_VERSION}"
  
  !define MHDDOS_PROXY_DIR "$INSTDIR\mhddos_proxy"
  
  !define DB1000N_DIR "$INSTDIR\db1000n"
  
  !define DISTRESS_DIR "$INSTDIR\distress"

  ;Installer Version Information
  VIAddVersionKey "ProductName" "${PRODUCT}"
  VIAddVersionKey "CompanyName" "IT ARMY of Ukraine"
  VIAddVersionKey "LegalCopyright" "Copyright ©2022 UkITA Installer"
  VIAddVersionKey "FileDescription" "UkITA Installer"
  VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"
  VIProductVersion "${PRODUCT_VERSION}.0"

  ;Define the main name of the installer
  Name "${PRODUCT}"

  ;Define the directory where the installer should be saved
  OutFile "output\${INSTALLER_NAME}.exe"



  # set to default here, override in .onInit if on 64bit
  InstallDir "$APPDATA\${INSTALLER_NAME}"


  ;Request rights if you want to install the program to program files
  RequestExecutionLevel admin


  ;Show 'console' in installer and uninstaller
  ShowInstDetails "show"
  ShowUninstDetails "show"

  ;Get installation folder from registry if available
  InstallDirRegKey HKLM "Software\${PRODUCT}" "InstallLocation"

;--------------------------------
;Interface Settings

  ;Show warning if user wants to abort
  !define MUI_ABORTWARNING

  ;Show all languages, despite user's codepage
  !define MUI_LANGDLL_ALLLANGUAGES

  ;Use optional a custom icon:
  !define MUI_ICON "resources\itarmy.ico" # for the Installer
  !define MUI_UNICON "resources\icon_uninstaller.ico" # for the later created UnInstaller

  ;Use optional a custom picture for the 'Welcome' and 'Finish' page:
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_RIGHT
  !define MUI_HEADERIMAGE_BITMAP "resources\headerimage-r.bmp"
  !define MUI_HEADERIMAGE_UNBITMAP "resources\headerimage-uninstall-r.bmp"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "resources\welcomefinishimage.bmp"  # for the Installer
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "resources\unwelcomefinishimage.bmp"  # for the later created UnInstaller

  ;Optional no descripton for all components
  !define MUI_COMPONENTSPAGE_NODESC

;--------------------------------
;Remember the unistaller/installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKLM"
  !define MUI_LANGDLL_REGISTRY_KEY "Software\${PRODUCT}"
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"
  
;--------------------------------
;Pages
  ;For the installer
  !insertmacro MUI_PAGE_WELCOME # simply remove this and other pages if you don't want it
  
  Page Custom Page_Win7Info
  
  !insertmacro MUI_PAGE_LICENSE "LICENSE" # link to an ANSI encoded license file
  !insertmacro MUI_PAGE_COMPONENTS # remove if you don't want to list components
  !insertmacro MUI_PAGE_DIRECTORY
  
  Page Custom Page_TermsOfUse
  
  !insertmacro MUI_PAGE_INSTFILES

  !define MUI_PAGE_CUSTOMFUNCTION_SHOW ShowFinishCheckbox
  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE OpenFinishLink

  !insertmacro MUI_PAGE_FINISH

  ;For the uninstaller
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH