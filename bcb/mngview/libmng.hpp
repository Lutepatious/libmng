// Borland C++ Builder
// Copyright (c) 1995, 1998 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'libmng.pas' rev: 3.00

#ifndef libmngHPP
#define libmngHPP
#include <SysInit.hpp>
#include <System.hpp>

//-- user supplied -----------------------------------------------------------

namespace Libmng
{
//-- type declarations -------------------------------------------------------
typedef Cardinal mng_uint32;

typedef int mng_int32;

typedef Word mng_uint16;

typedef short mng_int16;

typedef Byte mng_uint8;

typedef Shortint mng_int8;

typedef bool mng_bool;

typedef void *mng_ptr;

typedef char *mng_pchar;

typedef void *mng_handle;

typedef int mng_retcode;

typedef Cardinal mng_chunkid;

typedef Cardinal mng_size_t;

enum mng_imgtype { mng_it_unknown, mng_it_png, mng_it_mng, mng_it_jng };

enum mng_speedtype { mng_st_normal, mng_st_fast, mng_st_slow, mng_st_slowest };

typedef Cardinal *mng_uint32p;

typedef Word *mng_uint16p;

typedef Byte *mng_uint8p;

typedef Cardinal *mng_chunkidp;

#pragma pack(push, 1)
struct mng_palette8e
{
	Byte iRed;
	Byte iGreen;
	Byte iBlue;
} ;
#pragma pack(pop)

typedef mng_palette8e mng_palette8[256];

typedef Byte mng_uint8arr[256];

typedef Byte mng_uint8arr4[4];

typedef Word mng_uint16arr[256];

typedef Cardinal mng_uint32arr2[2];

typedef void * __stdcall (*mng_memalloc)(Cardinal iLen);

typedef void __stdcall (*mng_memfree)(void * iPtr, Cardinal iLen);

typedef bool __stdcall (*mng_openstream)(void * hHandle);

typedef bool __stdcall (*mng_closestream)(void * hHandle);

typedef bool __stdcall (*mng_readdata)(void * hHandle, void * pBuf, Cardinal iBuflen, Cardinal &pRead
	);

typedef bool __stdcall (*mng_writedata)(void * hHandle, void * pBuf, Cardinal iBuflen, Cardinal &pWritten
	);

typedef bool __stdcall (*mng_errorproc)(void * hHandle, int iErrorcode, Byte iSeverity, Cardinal iChunkname
	, Cardinal iChunkseq, int iExtra1, int iExtra2, char * zErrortext);

typedef bool __stdcall (*mng_traceproc)(void * hHandle, int iFuncnr, Cardinal iFuncseq, char * zFuncname
	);

typedef bool __stdcall (*mng_processheader)(void * hHandle, Cardinal iWidth, Cardinal iHeight);

typedef bool __stdcall (*mng_processtext)(void * hHandle, Byte iType, char * zKeyword, char * zText, 
	char * zLanguage, char * zTranslation);

typedef void * __stdcall (*mng_getcanvasline)(void * hHandle, Cardinal iLinenr);

typedef void * __stdcall (*mng_getalphaline)(void * hHandle, Cardinal iLinenr);

typedef void * __stdcall (*mng_getbkgdline)(void * hHandle, Cardinal iLinenr);

typedef bool __stdcall (*mng_refresh)(void * hHandle, Cardinal iX, Cardinal iY, Cardinal iWidth, Cardinal 
	iHeight);

typedef Cardinal __stdcall (*mng_gettickcount)(void * hHandle);

typedef bool __stdcall (*mng_settimer)(void * hHandle, Cardinal iMsecs);

typedef bool __stdcall (*mng_processgamma)(void * hHandle, Cardinal iGamma);

typedef bool __stdcall (*mng_processchroma)(void * hHandle, Cardinal iWhitex, Cardinal iWhitey, Cardinal 
	iRedx, Cardinal iRedy, Cardinal iGreenx, Cardinal iGreeny, Cardinal iBluex, Cardinal iBluey);

typedef bool __stdcall (*mng_processsrgb)(void * hHandle, Byte iIntent);

typedef bool __stdcall (*mng_processiccp)(void * hHandle, Cardinal iProfilesize, void * pProfile);

typedef bool __stdcall (*mng_processarow)(void * hHandle, Cardinal iRowsamples, bool bIsRGBA16, void * 
	pRow);

typedef bool __stdcall (*mng_iteratechunk)(void * hHandle, void * hChunk, Cardinal iChunkid, Cardinal 
	iChunkseq);

//-- var, const, procedure ---------------------------------------------------
#define MNG_TRUE (bool)(1)
#define MNG_FALSE (bool)(0)
#define MNG_NULL (void *)(0x0)
#define MNG_NOERROR (Byte)(0)
#define MNG_OUTOFMEMORY (Byte)(1)
#define MNG_INVALIDHANDLE (Byte)(2)
#define MNG_NOCALLBACK (Byte)(3)
#define MNG_UNEXPECTEDEOF (Byte)(4)
#define MNG_ZLIBERROR (Byte)(5)
#define MNG_JPEGERROR (Byte)(6)
#define MNG_LCMSERROR (Byte)(7)
#define MNG_NOOUTPUTPROFILE (Byte)(8)
#define MNG_NOSRGBPROFILE (Byte)(9)
#define MNG_BUFOVERFLOW (Byte)(10)
#define MNG_FUNCTIONINVALID (Byte)(11)
#define MNG_OUTPUTERROR (Byte)(12)
#define MNG_JPEGBUFTOOSMALL (Byte)(13)
#define MNG_NEEDMOREDATA (Byte)(14)
#define MNG_NEEDTIMERWAIT (Byte)(15)
#define MNG_NEEDSECTIONWAIT (Byte)(16)
#define MNG_APPIOERROR (Word)(901)
#define MNG_APPTIMERERROR (Word)(902)
#define MNG_APPCMSERROR (Word)(903)
#define MNG_APPMISCERROR (Word)(904)
#define MNG_APPTRACEABORT (Word)(905)
#define MNG_INTERNALERROR (Word)(999)
#define MNG_INVALIDSIG (Word)(1025)
#define MNG_INVALIDCRC (Word)(1027)
#define MNG_INVALIDLENGTH (Word)(1028)
#define MNG_SEQUENCEERROR (Word)(1029)
#define MNG_CHUNKNOTALLOWED (Word)(1030)
#define MNG_MULTIPLEERROR (Word)(1031)
#define MNG_PLTEMISSING (Word)(1032)
#define MNG_IDATMISSING (Word)(1033)
#define MNG_CANNOTBEEMPTY (Word)(1034)
#define MNG_GLOBALLENGTHERR (Word)(1035)
#define MNG_INVALIDBITDEPTH (Word)(1036)
#define MNG_INVALIDCOLORTYPE (Word)(1037)
#define MNG_INVALIDCOMPRESS (Word)(1038)
#define MNG_INVALIDFILTER (Word)(1039)
#define MNG_INVALIDINTERLACE (Word)(1040)
#define MNG_NOTENOUGHIDAT (Word)(1041)
#define MNG_PLTEINDEXERROR (Word)(1042)
#define MNG_NULLNOTFOUND (Word)(1043)
#define MNG_KEYWORDNULL (Word)(1044)
#define MNG_OBJECTUNKNOWN (Word)(1045)
#define MNG_OBJECTEXISTS (Word)(1046)
#define MNG_TOOMUCHIDAT (Word)(1047)
#define MNG_INVSAMPLEDEPTH (Word)(1048)
#define MNG_INVOFFSETSIZE (Word)(1049)
#define MNG_INVENTRYTYPE (Word)(1050)
#define MNG_ENDWITHNULL (Word)(1051)
#define MNG_INVIMAGETYPE (Word)(1052)
#define MNG_INVDELTATYPE (Word)(1053)
#define MNG_INVALIDINDEX (Word)(1054)
#define MNG_TOOMUCHJDAT (Word)(1055)
#define MNG_JPEGPARMSERR (Word)(1056)
#define MNG_INVFILLMETHOD (Word)(1057)
#define MNG_OBJNOTCONCRETE (Word)(1058)
#define MNG_TARGETNOALPHA (Word)(1059)
#define MNG_INVALIDCNVSTYLE (Word)(2049)
#define MNG_WRONGCHUNK (Word)(2050)
#define MNG_INVALIDENTRYIX (Word)(2051)
#define MNG_NOHEADER (Word)(2052)
#define MNG_NOCORRCHUNK (Word)(2053)
#define MNG_NOMHDR (Word)(2054)
#define MNG_IMAGETOOLARGE (Word)(4097)
#define MNG_NOTANANIMATION (Word)(4098)
#define MNG_FRAMENRTOOHIGH (Word)(4099)
#define MNG_LAYERNRTOOHIGH (Word)(4100)
#define MNG_PLAYTIMETOOHIGH (Word)(4101)
#define MNG_FNNOTIMPLEMENTED (Word)(4102)
#define MNG_IMAGEFROZEN (Word)(8193)
#define MNG_CANVAS_RGB8 (Byte)(0)
#define MNG_CANVAS_RGBA8 (Word)(4096)
#define MNG_CANVAS_ARGB8 (Word)(12288)
#define MNG_CANVAS_RGB8_A8 (Word)(20480)
#define MNG_CANVAS_BGR8 (Byte)(1)
#define MNG_CANVAS_BGRA8 (Word)(4097)
#define MNG_CANVAS_ABGR8 (Word)(12289)
#define MNG_CANVAS_RGB16 (Word)(256)
#define MNG_CANVAS_RGBA16 (Word)(4352)
#define MNG_CANVAS_ARGB16 (Word)(12544)
#define MNG_CANVAS_BGR16 (Word)(257)
#define MNG_CANVAS_BGRA16 (Word)(4353)
#define MNG_CANVAS_ABGR16 (Word)(12545)
#define MNG_CANVAS_GRAY8 (Byte)(2)
#define MNG_CANVAS_GRAY16 (Word)(258)
#define MNG_CANVAS_GRAYA8 (Word)(4098)
#define MNG_CANVAS_GRAYA16 (Word)(4354)
#define MNG_CANVAS_AGRAY8 (Word)(12290)
#define MNG_CANVAS_AGRAY16 (Word)(12546)
#define MNG_CANVAS_DX15 (Byte)(3)
#define MNG_CANVAS_DX16 (Byte)(4)
#define MNG_UINT_HUH (int)(1077952576)
#define MNG_UINT_BACK (int)(1111573323)
#define MNG_UINT_BASI (int)(1111577417)
#define MNG_UINT_CLIP (int)(1129072976)
#define MNG_UINT_CLON (int)(1129074510)
#define MNG_UINT_DBYK (int)(1145198923)
#define MNG_UINT_DEFI (int)(1145390665)
#define MNG_UINT_DHDR (int)(1145586770)
#define MNG_UINT_DISC (int)(1145656131)
#define MNG_UINT_DROP (int)(1146244944)
#define MNG_UINT_ENDL (int)(1162757196)
#define MNG_UINT_FRAM (int)(1179795789)
#define MNG_UINT_IDAT (int)(1229209940)
#define MNG_UINT_IEND (int)(1229278788)
#define MNG_UINT_IHDR (int)(1229472850)
#define MNG_UINT_IJNG (int)(1229606471)
#define MNG_UINT_IPNG (int)(1229999687)
#define MNG_UINT_JDAT (int)(1245987156)
#define MNG_UINT_JHDR (int)(1246250066)
#define MNG_UINT_JSEP (int)(1246971216)
#define MNG_UINT_LOOP (int)(1280266064)
#define MNG_UINT_MEND (int)(1296387652)
#define MNG_UINT_MHDR (int)(1296581714)
#define MNG_UINT_MOVE (int)(1297045061)
#define MNG_UINT_ORDR (int)(1330791506)
#define MNG_UINT_PAST (int)(1346458452)
#define MNG_UINT_PLTE (int)(1347179589)
#define MNG_UINT_PPLT (int)(1347439700)
#define MNG_UINT_PROM (int)(1347571533)
#define MNG_UINT_SAVE (int)(1396790853)
#define MNG_UINT_SEEK (int)(1397048651)
#define MNG_UINT_SHOW (int)(1397247831)
#define MNG_UINT_TERM (int)(1413829197)
#define MNG_UINT_bKGD (int)(1649100612)
#define MNG_UINT_cHRM (int)(1665684045)
#define MNG_UINT_eXPI (int)(1700286537)
#define MNG_UINT_fPRI (int)(1716539977)
#define MNG_UINT_gAMA (int)(1732332865)
#define MNG_UINT_hIST (int)(1749635924)
#define MNG_UINT_iCCP (int)(1766015824)
#define MNG_UINT_iTXt (int)(1767135348)
#define MNG_UINT_nEED (int)(1850033476)
#define MNG_UINT_oFFs (int)(1866876531)
#define MNG_UINT_pCAL (int)(1883455820)
#define MNG_UINT_pHYg (int)(1883521383)
#define MNG_UINT_pHYs (int)(1883789683)
#define MNG_UINT_sBIT (int)(1933723988)
#define MNG_UINT_sCAL (int)(1933787468)
#define MNG_UINT_sPLT (int)(1934642260)
#define MNG_UINT_sRGB (int)(1934772034)
#define MNG_UINT_tEXt (int)(1950701684)
#define MNG_UINT_tIME (int)(1950960965)
#define MNG_UINT_tRNS (int)(1951551059)
#define MNG_UINT_zTXt (int)(2052348020)
extern "C" void * __stdcall mng_initialize(void * pUserdata, mng_memalloc fMemalloc, mng_memfree fMemfree
	, mng_traceproc fTraceproc);
extern "C" int __stdcall mng_reset(void * hHandle);
extern "C" int __stdcall mng_cleanup(void * &hHandle);
extern "C" int __stdcall mng_read(void * hHandle);
extern "C" int __stdcall mng_read_resume(void * hHandle);
extern "C" int __stdcall mng_write(void * hHandle);
extern "C" int __stdcall mng_create(void * hHandle);
extern "C" int __stdcall mng_readdisplay(void * hHandle);
extern "C" int __stdcall mng_display(void * hHandle);
extern "C" int __stdcall mng_display_resume(void * hHandle);
extern "C" int __stdcall mng_display_freeze(void * hHandle);
extern "C" int __stdcall mng_display_reset(void * hHandle);
extern "C" int __stdcall mng_display_goframe(void * hHandle, Cardinal iFramenr);
extern "C" int __stdcall mng_display_golayer(void * hHandle, Cardinal iLayernr);
extern "C" int __stdcall mng_display_gotime(void * hHandle, Cardinal iPlaytime);
extern "C" int __stdcall mng_getlasterror(void * hHandle, Byte &iSeverity, Cardinal &iChunkname, Cardinal 
	&iChunkseq, int &iExtra1, int &iExtra2, char * &zErrortext);
extern "C" int __stdcall mng_setcb_memalloc(void * hHandle, mng_memalloc fProc);
extern "C" int __stdcall mng_setcb_memfree(void * hHandle, mng_memfree fProc);
extern "C" int __stdcall mng_setcb_openstream(void * hHandle, mng_openstream fProc);
extern "C" int __stdcall mng_setcb_closestream(void * hHandle, mng_closestream fProc);
extern "C" int __stdcall mng_setcb_readdata(void * hHandle, mng_readdata fProc);
extern "C" int __stdcall mng_setcb_writedata(void * hHandle, mng_writedata fProc);
extern "C" int __stdcall mng_setcb_errorproc(void * hHandle, mng_errorproc fProc);
extern "C" int __stdcall mng_setcb_traceproc(void * hHandle, mng_traceproc fProc);
extern "C" int __stdcall mng_setcb_processheader(void * hHandle, mng_processheader fProc);
extern "C" int __stdcall mng_setcb_processtext(void * hHandle, mng_processtext fProc);
extern "C" int __stdcall mng_setcb_getcanvasline(void * hHandle, mng_getcanvasline fProc);
extern "C" int __stdcall mng_setcb_getalphaline(void * hHandle, mng_getalphaline fProc);
extern "C" int __stdcall mng_setcb_getbkgdline(void * hHandle, mng_getbkgdline fProc);
extern "C" int __stdcall mng_setcb_refresh(void * hHandle, mng_refresh fProc);
extern "C" int __stdcall mng_setcb_gettickcount(void * hHandle, mng_gettickcount fProc);
extern "C" int __stdcall mng_setcb_settimer(void * hHandle, mng_settimer fProc);
extern "C" int __stdcall mng_setcb_processgamma(void * hHandle, mng_processgamma fProc);
extern "C" int __stdcall mng_setcb_processchroma(void * hHandle, mng_processchroma fProc);
extern "C" int __stdcall mng_setcb_processsrgb(void * hHandle, mng_processsrgb fProc);
extern "C" int __stdcall mng_setcb_processiccp(void * hHandle, mng_processiccp fProc);
extern "C" int __stdcall mng_setcb_processarow(void * hHandle, mng_processarow fProc);
extern "C" mng_memalloc __stdcall mng_getcb_memalloc(void * hHandle);
extern "C" mng_memfree __stdcall mng_getcb_memfree(void * hHandle);
extern "C" mng_openstream __stdcall mng_getcb_openstream(void * hHandle);
extern "C" mng_closestream __stdcall mng_getcb_closestream(void * hHandle);
extern "C" mng_readdata __stdcall mng_getcb_readdata(void * hHandle);
extern "C" mng_writedata __stdcall mng_getcb_writedata(void * hHandle);
extern "C" mng_errorproc __stdcall mng_getcb_errorproc(void * hHandle);
extern "C" mng_traceproc __stdcall mng_getcb_traceproc(void * hHandle);
extern "C" mng_processheader __stdcall mng_getcb_processheader(void * hHandle);
extern "C" mng_processtext __stdcall mng_getcb_processtext(void * hHandle);
extern "C" mng_getcanvasline __stdcall mng_getcb_getcanvasline(void * hHandle);
extern "C" mng_getalphaline __stdcall mng_getcb_getalphaline(void * hHandle);
extern "C" mng_getbkgdline __stdcall mng_getcb_getbkgdline(void * hHandle);
extern "C" mng_refresh __stdcall mng_getcb_refresh(void * hHandle);
extern "C" mng_gettickcount __stdcall mng_getcb_gettickcount(void * hHandle);
extern "C" mng_settimer __stdcall mng_getcb_settimer(void * hHandle);
extern "C" mng_processgamma __stdcall mng_getcb_processgamma(void * hHandle);
extern "C" mng_processchroma __stdcall mng_getcb_processchroma(void * hHandle);
extern "C" mng_processsrgb __stdcall mng_getcb_processsrgb(void * hHandle);
extern "C" mng_processiccp __stdcall mng_getcb_processiccp(void * hHandle);
extern "C" mng_processarow __stdcall mng_getcb_processarow(void * hHandle);
extern "C" int __stdcall mng_set_userdata(void * hHandle, void * pUserdata);
extern "C" int __stdcall mng_set_canvasstyle(void * hHandle, Cardinal iStyle);
extern "C" int __stdcall mng_set_bkgdstyle(void * hHandle, Cardinal iStyle);
extern "C" int __stdcall mng_set_bgcolor(void * hHandle, Word iRed, Word iGreen, Word iBlue);
extern "C" int __stdcall mng_set_storechunks(void * hHandle, bool bStorechunks);
extern "C" int __stdcall mng_set_viewgammaint(void * hHandle, Cardinal iGamma);
extern "C" int __stdcall mng_set_displaygammaint(void * hHandle, Cardinal iGamma);
extern "C" int __stdcall mng_set_dfltimggammaint(void * hHandle, Cardinal iGamma);
extern "C" int __stdcall mng_set_srgb(void * hHandle, bool bIssRGB);
extern "C" int __stdcall mng_set_outputprofile(void * hHandle, char * zFilename);
extern "C" int __stdcall mng_set_outputprofile2(void * hHandle, Cardinal iProfilesize, void * pProfile
	);
extern "C" int __stdcall mng_set_srgbprofile(void * hHandle, char * zFilename);
extern "C" int __stdcall mng_set_srgbprofile2(void * hHandle, Cardinal iProfilesize, void * pProfile
	);
extern "C" int __stdcall mng_set_maxcanvaswidth(void * hHandle, Cardinal iMaxwidth);
extern "C" int __stdcall mng_set_maxcanvasheight(void * hHandle, Cardinal iMaxheight);
extern "C" int __stdcall mng_set_maxcanvassize(void * hHandle, Cardinal iMaxwidth, Cardinal iMaxheight
	);
extern "C" int __stdcall mng_set_suspensionmode(void * hHandle, bool bSuspensionmode);
extern "C" int __stdcall mng_set_speed(void * hHandle, mng_speedtype iSpeed);
extern "C" void * __stdcall mng_get_userdata(void * hHandle);
extern "C" mng_imgtype __stdcall mng_get_sigtype(void * hHandle);
extern "C" mng_imgtype __stdcall mng_get_imagetype(void * hHandle);
extern "C" Cardinal __stdcall mng_get_imagewidth(void * hHandle);
extern "C" Cardinal __stdcall mng_get_imageheight(void * hHandle);
extern "C" Cardinal __stdcall mng_get_ticks(void * hHandle);
extern "C" Cardinal __stdcall mng_get_framecount(void * hHandle);
extern "C" Cardinal __stdcall mng_get_layercount(void * hHandle);
extern "C" Cardinal __stdcall mng_get_playtime(void * hHandle);
extern "C" Cardinal __stdcall mng_get_simplicity(void * hHandle);
extern "C" Cardinal __stdcall mng_get_canvasstyle(void * hHandle);
extern "C" Cardinal __stdcall mng_get_bkgdstyle(void * hHandle);
extern "C" void __stdcall mng_get_bgcolor(void * hHandle, Word &iRed, Word &iGreen, Word &iBlue);
extern "C" bool __stdcall mng_get_storechunks(void * hHandle);
extern "C" Cardinal __stdcall mng_get_viewgammaint(void * hHandle);
extern "C" Cardinal __stdcall mng_get_displaygammaint(void * hHandle);
extern "C" Cardinal __stdcall mng_get_dfltimggammaint(void * hHandle);
extern "C" bool __stdcall mng_get_srgb(void * hHandle);
extern "C" Cardinal __stdcall mng_get_maxcanvaswidth(void * hHandle);
extern "C" Cardinal __stdcall mng_get_maxcanvasheight(void * hHandle);
extern "C" bool __stdcall mng_get_suspensionmode(void * hHandle);
extern "C" mng_speedtype __stdcall mng_get_speed(void * hHandle);
extern "C" Cardinal __stdcall mng_get_imagelevel(void * hHandle);
extern "C" Cardinal __stdcall mng_get_starttime(void * hHandle);
extern "C" Cardinal __stdcall mng_get_runtime(void * hHandle);
extern "C" Cardinal __stdcall mng_get_currentframe(void * hHandle);
extern "C" Cardinal __stdcall mng_get_currentlayer(void * hHandle);
extern "C" Cardinal __stdcall mng_get_currentplaytime(void * hHandle);
extern "C" bool __stdcall mng_status_error(void * hHandle);
extern "C" bool __stdcall mng_status_reading(void * hHandle);
extern "C" bool __stdcall mng_status_suspendbreak(void * hHandle);
extern "C" bool __stdcall mng_status_creating(void * hHandle);
extern "C" bool __stdcall mng_status_writing(void * hHandle);
extern "C" bool __stdcall mng_status_displaying(void * hHandle);
extern "C" bool __stdcall mng_status_running(void * hHandle);
extern "C" bool __stdcall mng_status_timerbreak(void * hHandle);
extern "C" int __stdcall mng_iterate_chunks(void * hHandle, Cardinal iChunkseq, mng_iteratechunk fProc
	);
extern "C" int __stdcall mng_getchunk_ihdr(void * hHandle, void * hChunk, Cardinal &iWidth, Cardinal 
	&iHeight, Byte &iBitdepth, Byte &iColortype, Byte &iCompression, Byte &iFilter, Byte &iInterlace);
extern "C" int __stdcall mng_getchunk_plte(void * hHandle, void * hChunk, Cardinal &iCount, mng_palette8e 
	* aPalette);
extern "C" int __stdcall mng_getchunk_idat(void * hHandle, void * hChunk, Cardinal &iRawlen, void * 
	&pRawdata);
extern "C" int __stdcall mng_getchunk_trns(void * hHandle, void * hChunk, bool &bEmpty, bool &bGlobal
	, Byte &iType, Cardinal &iCount, Byte * aAlphas, Word &iGray, Word &iRed, Word &iGreen, Word &iBlue
	, Cardinal &iRawlen, Byte * aRawdata);
extern "C" int __stdcall mng_getchunk_gama(void * hHandle, void * hChunk, bool &bEmpty, Cardinal &iGamma
	);
extern "C" int __stdcall mng_getchunk_chrm(void * hHandle, void * hChunk, bool &bEmpty, Cardinal &iWhitepointx
	, Cardinal &iWhitepointy, Cardinal &iRedx, Cardinal &iRedy, Cardinal &iGreenx, Cardinal &iGreeny, Cardinal 
	&iBluex, Cardinal &iBluey);
extern "C" int __stdcall mng_getchunk_srgb(void * hHandle, void * hChunk, bool &bEmpty, Byte &iRenderingintent
	);
extern "C" int __stdcall mng_getchunk_iccp(void * hHandle, void * hChunk, bool &bEmpty, Cardinal &iNamesize
	, char * &zName, Byte &iCompression, Cardinal &iProfilesize, void * &pProfile);
extern "C" int __stdcall mng_getchunk_text(void * hHandle, void * hChunk, Cardinal &iKeywordsize, char * 
	&zKeyword, Cardinal &iTextsize, char * &zText);
extern "C" int __stdcall mng_getchunk_ztxt(void * hHandle, void * hChunk, Cardinal &iKeywordsize, char * 
	&zKeyword, Byte &iCompression, Cardinal &iTextsize, char * &zText);
extern "C" int __stdcall mng_getchunk_itxt(void * hHandle, void * hChunk, Cardinal &iKeywordsize, char * 
	&zKeyword, Byte &iCompressionflag, Byte &iCompressionmethod, Cardinal &iLanguagesize, char * &zLanguage
	, Cardinal &iTranslationsize, char * &zTranslation, Cardinal &iTextsize, char * &zText);
extern "C" int __stdcall mng_getchunk_bkgd(void * hHandle, void * hChunk, bool &bEmpty, Byte &iType, 
	Byte &iIndex, Word &iGray, Word &iRed, Word &iGreen, Word &iBlue);
extern "C" int __stdcall mng_getchunk_phys(void * hHandle, void * hChunk, bool &bEmpty, Cardinal &iSizex
	, Cardinal &iSizey, Byte &iUnit);
extern "C" int __stdcall mng_getchunk_sbit(void * hHandle, void * hChunk, bool &bEmpty, Byte &iType, 
	Byte * aBits);
extern "C" int __stdcall mng_getchunk_splt(void * hHandle, void * hChunk, bool &bEmpty, Cardinal &iNamesize
	, char * &zName, Byte &iSampledepth, Cardinal &iEntrycount, void * &pEntries);
extern "C" int __stdcall mng_getchunk_hist(void * hHandle, void * hChunk, Cardinal &iEntrycount, Word 
	* aEntries);
extern "C" int __stdcall mng_getchunk_time(void * hHandle, void * hChunk, Word &iYear, Byte &iMonth, 
	Byte &iDay, Byte &iHour, Byte &iMinute, Byte &iSecond);
extern "C" int __stdcall mng_getchunk_mhdr(void * hHandle, void * hChunk, Cardinal &iWidth, Cardinal 
	&iHeight, Cardinal &iTicks, Cardinal &iLayercount, Cardinal &iFramecount, Cardinal &iPlaytime, Cardinal 
	&iSimplicity);
extern "C" int __stdcall mng_getchunk_loop(void * hHandle, void * hChunk, Byte &iLevel, Cardinal &iRepeat
	, Byte &iTermination, Cardinal &iItermin, Cardinal &iItermax, Cardinal &iCount, mng_uint32p &pSignals
	);
extern "C" int __stdcall mng_getchunk_endl(void * hHandle, void * hChunk, Byte &iLevel);
extern "C" int __stdcall mng_getchunk_defi(void * hHandle, void * hChunk, Word &iObjectid, Byte &iDonotshow
	, Byte &iConcrete, bool &bHasloca, int &iXlocation, int &iYlocation, bool &bHasclip, int &iLeftcb, 
	int &iRightcb, int &iTopcb, int &iBottomcb);
extern "C" int __stdcall mng_getchunk_basi(void * hHandle, void * hChunk, Cardinal &iWidth, Cardinal 
	&iHeight, Byte &iBitdepth, Byte &iColortype, Byte &iCompression, Byte &iFilter, Byte &iInterlace, Word 
	&iRed, Word &iGreen, Word &iBlue, Word &iAlpha, Byte &iViewable);
extern "C" int __stdcall mng_getchunk_clon(void * hHandle, void * hChunk, Word &iSourceid, Word &iCloneid
	, Byte &iClonetype, Byte &iDonotshow, Byte &iConcrete, bool &bHasloca, Byte &iLocationtype, int &iLocationx
	, int &iLocationy);
extern "C" int __stdcall mng_getchunk_past(void * hHandle, void * hChunk, Word &iDestid, Byte &iTargettype
	, int &iTargetx, int &iTargety, Cardinal &iCount);
extern "C" int __stdcall mng_getchunk_past_src(void * hHandle, void * hChunk, Cardinal iEntry, Word 
	&iSourceid, Byte &iComposition, Byte &iOrientation, Byte &iOffsettype, int &iOffsetx, int &iOffsety
	, Byte &iBoundarytype, int &iBoundaryl, int &iBoundaryr, int &iBoundaryt, int &iBoundaryb);
extern "C" int __stdcall mng_getchunk_disc(void * hHandle, void * hChunk, Cardinal &iCount, mng_uint16p 
	&pObjectids);
extern "C" int __stdcall mng_getchunk_back(void * hHandle, void * hChunk, Word &iRed, Word &iGreen, 
	Word &iBlue, Byte &iMandatory, Word &iImageid, Byte &iTile);
extern "C" int __stdcall mng_getchunk_fram(void * hHandle, void * hChunk, bool &bEmpty, Byte &iMode, 
	Cardinal &iNamesize, char * &zName, Byte &iChangedelay, Byte &iChangetimeout, Byte &iChangeclipping
	, Byte &iChangesyncid, Cardinal &iDelay, Cardinal &iTimeout, Byte &iBoundarytype, int &iBoundaryl, 
	int &iBoundaryr, int &iBoundaryt, int &iBoundaryb, Cardinal &iCount, mng_uint32p &pSyncids);
extern "C" int __stdcall mng_getchunk_move(void * hHandle, void * hChunk, Word &iFirstid, Word &iLastid
	, Byte &iMovetype, int &iMovex, int &iMovey);
extern "C" int __stdcall mng_getchunk_clip(void * hHandle, void * hChunk, Word &iFirstid, Word &iLastid
	, Byte &iCliptype, int &iClipl, int &iClipr, int &iClipt, int &iClipb);
extern "C" int __stdcall mng_getchunk_show(void * hHandle, void * hChunk, bool &bEmpty, Word &iFirstid
	, Word &iLastid, Byte &iMode);
extern "C" int __stdcall mng_getchunk_term(void * hHandle, void * hChunk, Byte &iTermaction, Byte &iIteraction
	, Cardinal &iDelay, Cardinal &iItermax);
extern "C" int __stdcall mng_getchunk_save(void * hHandle, void * hChunk, bool &bEmpty, Byte &iOffsettype
	, Cardinal &iCount);
extern "C" int __stdcall mng_getchunk_save_entry(void * hHandle, void * hChunk, Cardinal iEntry, Byte 
	&iEntrytype, Cardinal * iOffset, Cardinal * iStarttime, Cardinal &iLayernr, Cardinal &iFramenr, Cardinal 
	&iNamesize, char * &zName);
extern "C" int __stdcall mng_getchunk_seek(void * hHandle, void * hChunk, Cardinal &iNamesize, char * 
	&zName);
extern "C" int __stdcall mng_getchunk_expi(void * hHandle, void * hChunk, Word &iSnapshotid, Cardinal 
	&iNamesize, char * &zName);
extern "C" int __stdcall mng_getchunk_fpri(void * hHandle, void * hChunk, Byte &iDeltatype, Byte &iPriority
	);
extern "C" int __stdcall mng_getchunk_need(void * hHandle, void * hChunk, Cardinal &iKeywordssize, char * 
	&zKeywords);
extern "C" int __stdcall mng_getchunk_phyg(void * hHandle, void * hChunk, bool &bEmpty, Cardinal &iSizex
	, Cardinal &iSizey, Byte &iUnit);
extern "C" int __stdcall mng_getchunk_jhdr(void * hHandle, void * hChunk, Cardinal &iWidth, Cardinal 
	&iHeight, Byte &iColortype, Byte &iImagesampledepth, Byte &iImagecompression, Byte &iImageinterlace
	, Byte &iAlphasampledepth, Byte &iAlphacompression, Byte &iAlphafilter, Byte &iAlphainterlace);
extern "C" int __stdcall mng_getchunk_jdat(void * hHandle, void * hChunk, Cardinal &iRawlen, void * 
	&pRawdata);
extern "C" int __stdcall mng_getchunk_dhdr(void * hHandle, void * hChunk, Word &iObjectid, Byte &iImagetype
	, Byte &iDeltatype, Cardinal &iBlockwidth, Cardinal &iBlockheight, Cardinal &iBlockx, Cardinal &iBlocky
	);
extern "C" int __stdcall mng_getchunk_prom(void * hHandle, void * hChunk, Byte &iColortype, Byte &iSampledepth
	, Byte &iFilltype);
extern "C" int __stdcall mng_getchunk_pplt(void * hHandle, void * hChunk, Cardinal &iCount);
extern "C" int __stdcall mng_getchunk_pplt_entry(void * hHandle, void * hChunk, Cardinal iEntry, Word 
	&iRed, Word &iGreen, Word &iBlue, Word &iAlpha, bool &bUsed);
extern "C" int __stdcall mng_getchunk_drop(void * hHandle, void * hChunk, Cardinal &iCount, mng_chunkidp 
	&pChunknames);
extern "C" int __stdcall mng_getchunk_dbyk(void * hHandle, void * hChunk, Cardinal &iChunkname, Byte 
	&iPolarity, Cardinal &iKeywordssize, char * &zKeywords);
extern "C" int __stdcall mng_getchunk_ordr(void * hHandle, void * hChunk, Cardinal &iCount);
extern "C" int __stdcall mng_getchunk_ordr_entry(void * hHandle, void * hChunk, Cardinal iEntry, Cardinal 
	&iChunkname, Byte &iOrdertype);
extern "C" int __stdcall mng_getchunk_unknown(void * hHandle, void * hChunk, Cardinal &iChunkname, Cardinal 
	&iRawlen, void * &pRawdata);
extern "C" int __stdcall mng_putchunk_ihdr(void * hHandle, Cardinal iWidth, Cardinal iHeight, Byte iBitdepth
	, Byte iColortype, Byte iCompression, Byte iFilter, Byte iInterlace);
extern "C" int __stdcall mng_putchunk_plte(void * hHandle, Cardinal iCount, const mng_palette8e * aPalette
	);
extern "C" int __stdcall mng_putchunk_idat(void * hHandle, Cardinal iRawlen, void * pRawdata);
extern "C" int __stdcall mng_putchunk_trns(void * hHandle, bool bEmpty, bool bGlobal, Byte iType, Cardinal 
	iCount, const Byte * aAlphas, Word iGray, Word iRed, Word iGreen, Word iBlue, Cardinal iRawlen, const 
	Byte * aRawdata);
extern "C" int __stdcall mng_putchunk_gama(void * hHandle, bool bEmpty, Cardinal iGamma);
extern "C" int __stdcall mng_putchunk_chrm(void * hHandle, bool bEmpty, Cardinal iWhitepointx, Cardinal 
	iWhitepointy, Cardinal iRedx, Cardinal iRedy, Cardinal iGreenx, Cardinal iGreeny, Cardinal iBluex, 
	Cardinal iBluey);
extern "C" int __stdcall mng_putchunk_srgb(void * hHandle, bool bEmpty, Byte iRenderingintent);
extern "C" int __stdcall mng_putchunk_iccp(void * hHandle, bool bEmpty, Cardinal iNamesize, char * zName
	, Byte iCompression, Cardinal iProfilesize, void * pProfile);
extern "C" int __stdcall mng_putchunk_text(void * hHandle, Cardinal iKeywordsize, char * zKeyword, Cardinal 
	iTextsize, char * zText);
extern "C" int __stdcall mng_putchunk_ztxt(void * hHandle, Cardinal iKeywordsize, char * zKeyword, Byte 
	iCompression, Cardinal iTextsize, char * zText);
extern "C" int __stdcall mng_putchunk_itxt(void * hHandle, Cardinal iKeywordsize, char * zKeyword, Byte 
	iCompressionflag, Byte iCompressionmethod, Cardinal iLanguagesize, char * zLanguage, Cardinal iTranslationsize
	, char * zTranslation, Cardinal iTextsize, char * zText);
extern "C" int __stdcall mng_putchunk_bkgd(void * hHandle, bool bEmpty, Byte iType, Byte iIndex, Word 
	iGray, Word iRed, Word iGreen, Word iBlue);
extern "C" int __stdcall mng_putchunk_phys(void * hHandle, bool bEmpty, Cardinal iSizex, Cardinal iSizey
	, Byte iUnit);
extern "C" int __stdcall mng_putchunk_sbit(void * hHandle, bool bEmpty, Byte iType, const Byte * aBits
	);
extern "C" int __stdcall mng_putchunk_splt(void * hHandle, bool bEmpty, Cardinal iNamesize, char * zName
	, Byte iSampledepth, Cardinal iEntrycount, void * pEntries);
extern "C" int __stdcall mng_putchunk_hist(void * hHandle, Cardinal iEntrycount, const Word * aEntries
	);
extern "C" int __stdcall mng_putchunk_time(void * hHandle, Word iYear, Byte iMonth, Byte iDay, Byte 
	iHour, Byte iMinute, Byte iSecond);
extern "C" int __stdcall mng_putchunk_mhdr(void * hHandle, Cardinal iWidth, Cardinal iHeight, Cardinal 
	iTicks, Cardinal iLayercount, Cardinal iFramecount, Cardinal iPlaytime, Cardinal iSimplicity);
extern "C" int __stdcall mng_putchunk_loop(void * hHandle, Byte iLevel, Cardinal iRepeat, Byte iTermination
	, Cardinal iItermin, Cardinal iItermax, Cardinal iCount, mng_uint32p pSignals);
extern "C" int __stdcall mng_putchunk_endl(void * hHandle, Byte iLevel);
extern "C" int __stdcall mng_putchunk_defi(void * hHandle, Word iObjectid, Byte iDonotshow, Byte iConcrete
	, bool bHasloca, int iXlocation, int iYlocation, bool bHasclip, int iLeftcb, int iRightcb, int iTopcb
	, int iBottomcb);
extern "C" int __stdcall mng_putchunk_basi(void * hHandle, Cardinal iWidth, Cardinal iHeight, Byte iBitdepth
	, Byte iColortype, Byte iCompression, Byte iFilter, Byte iInterlace, Word iRed, Word iGreen, Word iBlue
	, Word iAlpha, Byte iViewable);
extern "C" int __stdcall mng_putchunk_clon(void * hHandle, Word iSourceid, Word iCloneid, Byte iClonetype
	, Byte iDonotshow, Byte iConcrete, bool bHasloca, Byte iLocationtype, int iLocationx, int iLocationy
	);
extern "C" int __stdcall mng_putchunk_past(void * hHandle, Word iDestid, Byte iTargettype, int iTargetx
	, int iTargety, Cardinal iCount);
extern "C" int __stdcall mng_putchunk_past_src(void * hHandle, Cardinal iEntry, Word iSourceid, Byte 
	iComposition, Byte iOrientation, Byte iOffsettype, int iOffsetx, int iOffsety, Byte iBoundarytype, 
	int iBoundaryl, int iBoundaryr, int iBoundaryt, int iBoundaryb);
extern "C" int __stdcall mng_putchunk_disc(void * hHandle, Cardinal iCount, mng_uint16p pObjectids);
	
extern "C" int __stdcall mng_putchunk_back(void * hHandle, Word iRed, Word iGreen, Word iBlue, Byte 
	iMandatory, Word iImageid, Byte iTile);
extern "C" int __stdcall mng_putchunk_fram(void * hHandle, bool bEmpty, Byte iMode, Cardinal iNamesize
	, char * zName, Byte iChangedelay, Byte iChangetimeout, Byte iChangeclipping, Byte iChangesyncid, Cardinal 
	iDelay, Cardinal iTimeout, Byte iBoundarytype, int iBoundaryl, int iBoundaryr, int iBoundaryt, int 
	iBoundaryb, Cardinal iCount, mng_uint32p pSyncids);
extern "C" int __stdcall mng_putchunk_move(void * hHandle, Word iFirstid, Word iLastid, Byte iMovetype
	, int iMovex, int iMovey);
extern "C" int __stdcall mng_putchunk_clip(void * hHandle, Word iFirstid, Word iLastid, Byte iCliptype
	, int iClipl, int iClipr, int iClipt, int iClipb);
extern "C" int __stdcall mng_putchunk_show(void * hHandle, bool bEmpty, Word iFirstid, Word iLastid, 
	Byte iMode);
extern "C" int __stdcall mng_putchunk_term(void * hHandle, Byte iTermaction, Byte iIteraction, Cardinal 
	iDelay, Cardinal iItermax);
extern "C" int __stdcall mng_putchunk_save(void * hHandle, bool bEmpty, Byte iOffsettype, Cardinal iCount
	);
extern "C" int __stdcall mng_putchunk_save_entry(void * hHandle, Cardinal iEntry, Byte iEntrytype, const 
	Cardinal * iOffset, const Cardinal * iStarttime, Cardinal iLayernr, Cardinal iFramenr, Cardinal iNamesize
	, char * zName);
extern "C" int __stdcall mng_putchunk_seek(void * hHandle, Cardinal iNamesize, char * zName);
extern "C" int __stdcall mng_putchunk_expi(void * hHandle, Word iSnapshotid, Cardinal iNamesize, char * 
	zName);
extern "C" int __stdcall mng_putchunk_fpri(void * hHandle, Byte iDeltatype, Byte iPriority);
extern "C" int __stdcall mng_putchunk_need(void * hHandle, Cardinal iKeywordssize, char * zKeywords)
	;
extern "C" int __stdcall mng_putchunk_phyg(void * hHandle, bool bEmpty, Cardinal iSizex, Cardinal iSizey
	, Byte iUnit);
extern "C" int __stdcall mng_putchunk_jhdr(void * hHandle, Cardinal iWidth, Cardinal iHeight, Byte iColortype
	, Byte iImagesampledepth, Byte iImagecompression, Byte iImageinterlace, Byte iAlphasampledepth, Byte 
	iAlphacompression, Byte iAlphafilter, Byte iAlphainterlace);
extern "C" int __stdcall mng_putchunk_jdat(void * hHandle, Cardinal iRawlen, void * pRawdata);
extern "C" int __stdcall mng_putchunk_dhdr(void * hHandle, Word iObjectid, Byte iImagetype, Byte iDeltatype
	, Cardinal iBlockwidth, Cardinal iBlockheight, Cardinal iBlockx, Cardinal iBlocky);
extern "C" int __stdcall mng_putchunk_prom(void * hHandle, Byte iColortype, Byte iSampledepth, Byte 
	iFilltype);
extern "C" int __stdcall mng_putchunk_pplt(void * hHandle, Cardinal iCount);
extern "C" int __stdcall mng_putchunk_pplt_entry(void * hHandle, Cardinal iEntry, Word iRed, Word iGreen
	, Word iBlue, Word iAlpha, bool bUsed);
extern "C" int __stdcall mng_putchunk_drop(void * hHandle, Cardinal iCount, mng_chunkidp pChunknames
	);
extern "C" int __stdcall mng_putchunk_dbyk(void * hHandle, Cardinal iChunkname, Byte iPolarity, Cardinal 
	iKeywordssize, char * zKeywords);
extern "C" int __stdcall mng_putchunk_ordr(void * hHandle, Cardinal iCount);
extern "C" int __stdcall mng_putchunk_ordr_entry(void * hHandle, Cardinal iEntry, Cardinal iChunkname
	, Byte iOrdertype);
extern "C" int __stdcall mng_putchunk_unknown(void * hHandle, Cardinal iChunkname, Cardinal iRawlen, 
	void * pRawdata);
extern "C" int __stdcall mng_updatemngheader(void * hHandle, Cardinal iFramecount, Cardinal iLayercount
	, Cardinal iPlaytime);
extern "C" int __stdcall mng_updatemngsimplicity(void * hHandle, Cardinal iSimplicity);

}	/* namespace Libmng */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Libmng;
#endif
//-- end unit ----------------------------------------------------------------
#endif	// libmng
