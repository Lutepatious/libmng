//---------------------------------------------------------------------------

#include <windows.h>
#pragma hdrstop
#include <condefs.h>

//---------------------------------------------------------------------------

USERES("libmng.res");
USEDEF("..\libmng.def");
USEUNIT("..\..\mng_hlapi.c");
USEUNIT("..\..\mng_callback_xs.c");
USEUNIT("..\..\mng_prop_xs.c");
USEUNIT("..\..\mng_chunk_xs.c");
USEUNIT("..\..\mng_object_prc.c");
USEUNIT("..\..\mng_chunk_prc.c");
USEUNIT("..\..\mng_chunk_io.c");
USEUNIT("..\..\mng_read.c");
USEUNIT("..\..\mng_write.c");
USEUNIT("..\..\mng_display.c");
USEUNIT("..\..\mng_dither.c");
USEUNIT("..\..\mng_pixels.c");
USEUNIT("..\..\mng_filter.c");
USEUNIT("..\..\mng_error.c");
USEUNIT("..\..\mng_trace.c");
USEUNIT("..\..\mng_cms.c");
USEUNIT("..\..\mng_zlib.c");
USEUNIT("..\..\mng_jpeg.c");
USEUNIT("..\..\..\zlib\adler32.c");
USEUNIT("..\..\..\zlib\compress.c");
USEUNIT("..\..\..\zlib\crc32.c");
USEUNIT("..\..\..\zlib\deflate.c");
USEUNIT("..\..\..\zlib\infblock.c");
USEUNIT("..\..\..\zlib\infcodes.c");
USEUNIT("..\..\..\zlib\inffast.c");
USEUNIT("..\..\..\zlib\inflate.c");
USEUNIT("..\..\..\zlib\inftrees.c");
USEUNIT("..\..\..\zlib\infutil.c");
USEUNIT("..\..\..\zlib\trees.c");
USEUNIT("..\..\..\zlib\uncompr.c");
USEUNIT("..\..\..\zlib\zutil.c");
USELIB("..\..\..\lcms\lib\bc\lcmsstat.lib");
USEUNIT("..\..\..\jpgsrc6b\jquant2.c");
USEUNIT("..\..\..\jpgsrc6b\jcapistd.c");
USEUNIT("..\..\..\jpgsrc6b\jccoefct.c");
USEUNIT("..\..\..\jpgsrc6b\jccolor.c");
USEUNIT("..\..\..\jpgsrc6b\jcdctmgr.c");
USEUNIT("..\..\..\jpgsrc6b\jchuff.c");
USEUNIT("..\..\..\jpgsrc6b\jcinit.c");
USEUNIT("..\..\..\jpgsrc6b\jcmainct.c");
USEUNIT("..\..\..\jpgsrc6b\jcmarker.c");
USEUNIT("..\..\..\jpgsrc6b\jcmaster.c");
USEUNIT("..\..\..\jpgsrc6b\jcomapi.c");
USEUNIT("..\..\..\jpgsrc6b\jcparam.c");
USEUNIT("..\..\..\jpgsrc6b\jcphuff.c");
USEUNIT("..\..\..\jpgsrc6b\jcprepct.c");
USEUNIT("..\..\..\jpgsrc6b\jcsample.c");
USEUNIT("..\..\..\jpgsrc6b\jctrans.c");
USEUNIT("..\..\..\jpgsrc6b\jdapistd.c");
USEUNIT("..\..\..\jpgsrc6b\jdatadst.c");
USEUNIT("..\..\..\jpgsrc6b\jdatasrc.c");
USEUNIT("..\..\..\jpgsrc6b\jdcoefct.c");
USEUNIT("..\..\..\jpgsrc6b\jdcolor.c");
USEUNIT("..\..\..\jpgsrc6b\jddctmgr.c");
USEUNIT("..\..\..\jpgsrc6b\jdhuff.c");
USEUNIT("..\..\..\jpgsrc6b\jdinput.c");
USEUNIT("..\..\..\jpgsrc6b\jdmainct.c");
USEUNIT("..\..\..\jpgsrc6b\jdmarker.c");
USEUNIT("..\..\..\jpgsrc6b\jdmaster.c");
USEUNIT("..\..\..\jpgsrc6b\jdmerge.c");
USEUNIT("..\..\..\jpgsrc6b\jdphuff.c");
USEUNIT("..\..\..\jpgsrc6b\jdpostct.c");
USEUNIT("..\..\..\jpgsrc6b\jdsample.c");
USEUNIT("..\..\..\jpgsrc6b\jdtrans.c");
USEUNIT("..\..\..\jpgsrc6b\jerror.c");
USEUNIT("..\..\..\jpgsrc6b\jfdctflt.c");
USEUNIT("..\..\..\jpgsrc6b\jfdctfst.c");
USEUNIT("..\..\..\jpgsrc6b\jfdctint.c");
USEUNIT("..\..\..\jpgsrc6b\jidctflt.c");
USEUNIT("..\..\..\jpgsrc6b\jidctfst.c");
USEUNIT("..\..\..\jpgsrc6b\jidctint.c");
USEUNIT("..\..\..\jpgsrc6b\jidctred.c");
USEUNIT("..\..\..\jpgsrc6b\jmemmgr.c");
USEUNIT("..\..\..\jpgsrc6b\jmemnobs.c");
USEUNIT("..\..\..\jpgsrc6b\jquant1.c");
USEUNIT("..\..\..\jpgsrc6b\jcapimin.c");
USEUNIT("..\..\..\jpgsrc6b\jutils.c");
USEUNIT("..\..\..\jpgsrc6b\jdapimin.c");
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------

