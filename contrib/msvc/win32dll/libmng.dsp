# Microsoft Developer Studio Project File - Name="libmng" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=libmng - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libmng.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libmng.mak" CFG="libmng - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libmng - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "libmng - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libmng - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBMNG_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MD /W2 /GX /O2 /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBMNG_EXPORTS" /D "MNG_BUILD_DLL" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386

!ELSEIF  "$(CFG)" == "libmng - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBMNG_EXPORTS" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W2 /Gm /GX /ZI /Od /I "zlib" /I "jpeg" /I "lcms/include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBMNG_EXPORTS" /D "MNG_BUILD_DLL" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "libmng - Win32 Release"
# Name "libmng - Win32 Debug"
# Begin Group "mng"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\..\libmng.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_callback_xs.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_chunk_io.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_chunk_io.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_chunk_prc.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_chunk_prc.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_chunk_xs.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_chunks.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_cms.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_cms.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_conf.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_data.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_display.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_display.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_dither.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_dither.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_error.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_error.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_filter.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_filter.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_hlapi.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_jpeg.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_jpeg.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_memory.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_object_prc.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_object_prc.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_objects.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_pixels.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_pixels.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_prop_xs.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_read.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_read.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_trace.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_trace.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_types.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_write.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_write.h
# End Source File
# Begin Source File

SOURCE=..\..\libmng_zlib.c
# End Source File
# Begin Source File

SOURCE=..\..\libmng_zlib.h
# End Source File
# End Group
# Begin Group "jpeg"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\jpeg\jcapimin.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcapistd.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jccoefct.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jccolor.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcdctmgr.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jchuff.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jchuff.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcinit.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcmainct.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcmarker.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcmaster.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcomapi.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jconfig.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcparam.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcphuff.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcprepct.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jcsample.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jctrans.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdapimin.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdapistd.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdatadst.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdatasrc.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdcoefct.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdcolor.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdct.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jddctmgr.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdhuff.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdhuff.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdinput.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdmainct.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdmarker.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdmaster.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdmerge.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdphuff.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdpostct.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdsample.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jdtrans.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jerror.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jerror.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jfdctflt.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jfdctfst.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jfdctint.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jidctflt.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jidctfst.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jidctint.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jidctred.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jinclude.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jmemmgr.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jmemnobs.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jmemsys.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jmorecfg.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jpegint.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jpeglib.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\jquant1.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jquant2.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jutils.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\jversion.h
# End Source File
# Begin Source File

SOURCE=.\jpeg\transupp.c
# End Source File
# Begin Source File

SOURCE=.\jpeg\transupp.h
# End Source File
# End Group
# Begin Group "lcms"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\lcms\source\CMSCNVRT.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\CMSERR.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\CMSGAMMA.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\CMSGMT.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\cmsintrp.c
# End Source File
# Begin Source File

SOURCE=.\lcms\source\cmsio1.c
# End Source File
# Begin Source File

SOURCE=.\lcms\source\CMSLUT.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\CMSMATSH.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\cmsmtrx.c
# End Source File
# Begin Source File

SOURCE=.\lcms\source\CMSPACK.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\cmspcs.c
# End Source File
# Begin Source File

SOURCE=.\lcms\source\CMSWTPNT.C
# End Source File
# Begin Source File

SOURCE=.\lcms\source\cmsxform.c
# End Source File
# Begin Source File

SOURCE=..\..\..\lcms\include\icc34.h
# End Source File
# Begin Source File

SOURCE=.\lcms\include\icc34.h
# End Source File
# Begin Source File

SOURCE=.\lcms\include\lcms.h
# End Source File
# End Group
# Begin Group "zlib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\zlib\adler32.c
# End Source File
# Begin Source File

SOURCE=.\zlib\deflate.c
# End Source File
# Begin Source File

SOURCE=.\zlib\deflate.h
# End Source File
# Begin Source File

SOURCE=.\zlib\infblock.c
# End Source File
# Begin Source File

SOURCE=.\zlib\infblock.h
# End Source File
# Begin Source File

SOURCE=.\zlib\infcodes.c
# End Source File
# Begin Source File

SOURCE=.\zlib\infcodes.h
# End Source File
# Begin Source File

SOURCE=.\zlib\inffast.c
# End Source File
# Begin Source File

SOURCE=.\zlib\inffast.h
# End Source File
# Begin Source File

SOURCE=.\zlib\inffixed.h
# End Source File
# Begin Source File

SOURCE=.\zlib\inflate.c
# End Source File
# Begin Source File

SOURCE=.\zlib\inftrees.c
# End Source File
# Begin Source File

SOURCE=.\zlib\inftrees.h
# End Source File
# Begin Source File

SOURCE=.\zlib\infutil.c
# End Source File
# Begin Source File

SOURCE=.\zlib\infutil.h
# End Source File
# Begin Source File

SOURCE=.\zlib\trees.c
# End Source File
# Begin Source File

SOURCE=.\zlib\trees.h
# End Source File
# Begin Source File

SOURCE=.\zlib\zconf.h
# End Source File
# Begin Source File

SOURCE=.\zlib\zlib.h
# End Source File
# Begin Source File

SOURCE=.\zlib\zutil.c
# End Source File
# Begin Source File

SOURCE=.\zlib\zutil.h
# End Source File
# End Group
# End Target
# End Project
