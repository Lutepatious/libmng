unit libmng;

{****************************************************************************}
{*                                                                          *}
{*  COPYRIGHT NOTICE:                                                       *}
{*                                                                          *}
{*  Copyright (c) 2000 Gerard Juyn (gerard@libmng.com)                      *}
{*  [You may insert additional notices after this sentence if you modify    *}
{*   this source]                                                           *}
{*                                                                          *}
{*  For the purposes of this copyright and license, "Contributing Authors"  *}
{*  is defined as the following set of individuals:                         *}
{*                                                                          *}
{*     Gerard Juyn                                                          *}
{*     (hopefully some more to come...)                                     *}
{*                                                                          *}
{*  The MNG Library is supplied "AS IS".  The Contributing Authors          *}
{*  disclaim all warranties, expressed or implied, including, without       *}
{*  limitation, the warranties of merchantability and of fitness for any    *}
{*  purpose.  The Contributing Authors assume no liability for direct,      *}
{*  indirect, incidental, special, exemplary, or consequential damages,     *}
{*  which may result from the use of the MNG Library, even if advised of    *}
{*  the possibility of such damage.                                         *}
{*                                                                          *}
{*  Permission is hereby granted to use, copy, modify, and distribute this  *}
{*  source code, or portions hereof, for any purpose, without fee, subject  *}
{*  to the following restrictions:                                          *}
{*                                                                          *}
{*  1. The origin of this source code must not be misrepresented;           *}
{*     you must not claim that you wrote the original software.             *}
{*                                                                          *}
{*  2. Altered versions must be plainly marked as such and must not be      *}
{*     misrepresented as being the original source.                         *}
{*                                                                          *}
{*  3. This Copyright notice may not be removed or altered from any source  *}
{*     or altered source distribution.                                      *}
{*                                                                          *}
{*  The Contributing Authors specifically permit, without fee, and          *}
{*  encourage the use of this source code as a component to supporting      *}
{*  the MNG and JNG file format in commercial products.  If you use this    *}
{*  source code in a product, acknowledgment would be highly appreciated.   *}
{*                                                                          *}
{****************************************************************************}
{*                                                                          *}
{*  project   : libmng                                                      *}
{*  file      : libmng.pas                copyright (c) 2000 G.Juyn         *}
{*  version   : 0.5.1                                                       *}
{*                                                                          *}
{*  purpose   : libmng.dll wrapper unit                                     *}
{*                                                                          *}
{*  author    : G.Juyn                                                      *}
{*  web       : http://www.3-t.com                                          *}
{*  email     : mailto:info@3-t.com                                         *}
{*                                                                          *}
{*  comment   : contains the pascal-translation of libmng.h                 *}
{*              can be used by Delphi programs to access the libmng.dll     *}
{*                                                                          *}
{*  changes   : 0.5.1 - 05/02/2000 - G.Juyn                                 *}
{*              - added this version block                                  *}
{*              0.5.1 - 05/08/2000 - G.Juyn                                 *}
{*              - changed to stdcall convention                             *}
{*              0.5.1 - 05/11/2000 - G.Juyn                                 *}
{*              - changed callback prototypes                               *}
{*              - added TRUE/FALSE/NULL constants                           *}
{*              - added setoutputprofile2 & setsrgbprofile2                 *}
{*              - added several new types                                   *}
{*              - added chunk-access functions                              *}
{*              - added new error- & tracecodes                             *}
{*                                                                          *}
{****************************************************************************}

interface

{****************************************************************************}

const MNG_TRUE       = TRUE;
      MNG_FALSE      = FALSE;
      MNG_NULL       = 0;

type  mng_uint32     = cardinal;
      mng_int32      = integer;
      mng_uint16     = word;
      mng_int16      = smallint;
      mng_uint8      = byte;
      mng_int8       = shortint;
      mng_bool       = boolean;
      mng_ptr        = pointer;
      mng_pchar      = pchar;

      mng_handle     = mng_uint32;
      mng_retcode    = mng_int32;
      mng_chunkid    = mng_uint32;

      mng_imgtype    = (it_unknown, it_png, it_jng, it_mng);

      mng_uint32p    = ^mng_uint32;
      mng_uint16p    = ^mng_uint16;
      mng_chunkidp   = ^mng_chunkid;

      mng_palette8e  = record                    { 8-bit palette element }
                         iRed   : mng_uint8;
                         iGreen : mng_uint8;
                         iBlue  : mng_uint8;
                       end;

      mng_palette8   = array [0 .. 255] of mng_palette8e;

      mng_uint8arr   = array [0 .. 255] of mng_uint8;
      mng_uint8arr4  = array [0 ..   3] of mng_uint8;
      mng_uint16arr  = array [0 .. 255] of mng_uint16;
      mng_uint32arr2 = array [0 ..   1] of mng_uint32;

{****************************************************************************}

type mng_memalloc      = function  (    iLen         : mng_uint32) : mng_ptr; stdcall;
     mng_memfree       = procedure (    iPtr         : mng_ptr;
                                        iLen         : mng_uint32); stdcall;

type mng_openstream    = function  (    hHandle      : mng_handle) : mng_bool; stdcall;
type mng_closestream   = function  (    hHandle      : mng_handle) : mng_bool; stdcall;

type mng_readdata      = function  (    hHandle      : mng_handle;
                                        pBuf         : mng_ptr;
                                        iBuflen      : mng_uint32;
                                    var pRead        : mng_uint32) : mng_bool; stdcall;

type mng_writedata     = function  (    hHandle      : mng_handle;
                                        pBuf         : mng_ptr;
                                        iBuflen      : mng_uint32;
                                    var pWritten     : mng_uint32) : mng_bool; stdcall;

type mng_errorproc     = function  (    hHandle      : mng_handle;
                                        iErrorcode   : mng_retcode;
                                        iSeverity    : mng_uint8;
                                        iChunkname   : mng_chunkid;
                                        iChunkseq    : mng_uint32;
                                        iExtra1      : mng_int32;
                                        iExtra2      : mng_int32;
                                        zErrortext   : mng_pchar ) : mng_bool; stdcall;
type mng_traceproc     = function  (    hHandle      : mng_handle;
                                        iFuncnr      : mng_int32;
                                        iFuncseq     : mng_uint32;
                                        zFuncname    : mng_pchar ) : mng_bool; stdcall;

type mng_processheader = function  (    hHandle      : mng_handle;
                                        iWidth       : mng_uint32;
                                        iHeight      : mng_uint32) : mng_bool; stdcall;
type mng_processtext   = function  (    hHandle      : mng_handle;
                                        iType        : mng_uint8;
                                        zKeyword     : mng_pchar;
                                        zText        : mng_pchar;
                                        zLanguage    : mng_pchar;
                                        zTranslation : mng_pchar ) : mng_bool; stdcall;

type mng_getcanvasline = function  (    hHandle      : mng_handle;
                                        iLinenr      : mng_uint32) : mng_ptr; stdcall;
type mng_getbkgdline   = function  (    hHandle      : mng_handle;
                                        iLinenr      : mng_uint32) : mng_ptr; stdcall;
type mng_refresh       = function  (    hHandle      : mng_handle;
                                        iTop         : mng_uint32;
                                        iLeft        : mng_uint32;
                                        iBottom      : mng_uint32;
                                        iRight       : mng_uint32) : mng_bool; stdcall;

type mng_gettickcount  = function  (    hHandle      : mng_handle) : mng_uint32; stdcall;
type mng_settimer      = function  (    hHandle      : mng_handle;
                                        iMsecs       : mng_uint32) : mng_bool; stdcall;

type mng_processgamma  = function  (    hHandle      : mng_handle;
                                        iGamma       : mng_uint32) : mng_bool; stdcall;
type mng_processchroma = function  (    hHandle      : mng_handle;
                                        iWhitex      : mng_uint32;
                                        iWhitey      : mng_uint32;
                                        iRedx        : mng_uint32;
                                        iRedy        : mng_uint32;
                                        iGreenx      : mng_uint32;
                                        iGreeny      : mng_uint32;
                                        iBluex       : mng_uint32;
                                        iBluey       : mng_uint32) : mng_bool; stdcall;
type mng_processsrgb   = function  (    hHandle      : mng_handle;
                                        iIntent      : mng_uint8 ) : mng_bool; stdcall;
type mng_processiccp   = function  (    hHandle      : mng_handle;
                                        iProfilesize : mng_uint32;
                                        pProfile     : mng_ptr   ) : mng_bool; stdcall;
type mng_processarow   = function  (    hHandle      : mng_handle;
                                        iRowsamples  : mng_uint32;
                                        bIsRGBA16    : mng_bool;
                                        pRow         : mng_ptr   ) : mng_bool; stdcall;

type mng_iteratechunk  = function  (    hHandle      : mng_handle;
                                        hChunk       : mng_handle;
                                        iChunkid     : mng_chunkid;
                                        iChunkseq    : mng_uint32) : mng_bool; stdcall;

{****************************************************************************}

function  mng_initialize          (    iUserdata    : mng_int32;
                                       fMemalloc    : mng_memalloc;
                                       fMemfree     : mng_memfree;
                                       fTraceproc   : mng_traceproc    ) : mng_retcode;       stdcall;

function  mng_reset               (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;

function  mng_cleanup             (var hHandle      : mng_handle       ) : mng_retcode;       stdcall;

function  mng_read                (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;
function  mng_write               (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;
function  mng_create              (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;

function  mng_readdisplay         (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display             (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display_resume      (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display_freeze      (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display_reset       (    hHandle      : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display_goframe     (    hHandle      : mng_handle;
                                       iFramenr     : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_display_golayer     (    hHandle      : mng_handle;
                                       iLayernr     : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_display_gotime      (    hHandle      : mng_handle;
                                       iPlaytime    : mng_uint32       ) : mng_retcode;       stdcall;

function  mng_getlasterror        (    hHandle      : mng_handle;
                                   var iSeverity    : mng_uint8;
                                   var iChunkname   : mng_chunkid;
                                   var iChunkseq    : mng_uint32;
                                   var iExtra1      : mng_int32;
                                   var iExtra2      : mng_int32;
                                   var zErrortext   : mng_pchar        ) : mng_retcode;       stdcall;

{****************************************************************************}

function  mng_setcb_memalloc      (    hHandle      : mng_handle;
                                       fProc        : mng_memalloc     ) : mng_retcode;       stdcall;
function  mng_setcb_memfree       (    hHandle      : mng_handle;
                                       fProc        : mng_memfree      ) : mng_retcode;       stdcall;

function  mng_setcb_openstream    (    hHandle      : mng_handle;
                                       fProc        : mng_openstream   ) : mng_retcode;       stdcall;
function  mng_setcb_closestream   (    hHandle      : mng_handle;
                                       fProc        : mng_closestream  ) : mng_retcode;       stdcall;

function  mng_setcb_readdata      (    hHandle      : mng_handle;
                                       fProc        : mng_readdata     ) : mng_retcode;       stdcall;

function  mng_setcb_writedata     (    hHandle      : mng_handle;
                                       fProc        : mng_writedata    ) : mng_retcode;       stdcall;

function  mng_setcb_errorproc     (    hHandle      : mng_handle;
                                       fProc        : mng_errorproc    ) : mng_retcode;       stdcall;
function  mng_setcb_traceproc     (    hHandle      : mng_handle;
                                       fProc        : mng_traceproc    ) : mng_retcode;       stdcall;

function  mng_setcb_processheader (    hHandle      : mng_handle;
                                       fProc        : mng_processheader) : mng_retcode;       stdcall;
function  mng_setcb_processtext   (    hHandle      : mng_handle;
                                       fProc        : mng_processtext  ) : mng_retcode;       stdcall;

function  mng_setcb_getcanvasline (    hHandle      : mng_handle;
                                       fProc        : mng_getcanvasline) : mng_retcode;       stdcall;
function  mng_setcb_getbkgdline   (    hHandle      : mng_handle;
                                       fProc        : mng_getbkgdline  ) : mng_retcode;       stdcall;
function  mng_setcb_refresh       (    hHandle      : mng_handle;
                                       fProc        : mng_refresh      ) : mng_retcode;       stdcall;

function  mng_setcb_gettickcount  (    hHandle      : mng_handle;
                                       fProc        : mng_gettickcount ) : mng_retcode;       stdcall;
function  mng_setcb_settimer      (    hHandle      : mng_handle;
                                       fProc        : mng_settimer     ) : mng_retcode;       stdcall;

function  mng_setcb_processgamma  (    hHandle      : mng_handle;
                                       fProc        : mng_processgamma ) : mng_retcode;       stdcall;
function  mng_setcb_processchroma (    hHandle      : mng_handle;
                                       fProc        : mng_processchroma) : mng_retcode;       stdcall;
function  mng_setcb_processsrgb   (    hHandle      : mng_handle;
                                       fProc        : mng_processsrgb  ) : mng_retcode;       stdcall;
function  mng_setcb_processiccp   (    hHandle      : mng_handle;
                                       fProc        : mng_processiccp  ) : mng_retcode;       stdcall;
function  mng_setcb_processarow   (    hHandle      : mng_handle;
                                       fProc        : mng_processarow  ) : mng_retcode;       stdcall;

{****************************************************************************}

function  mng_getcb_memalloc      (    hHandle      : mng_handle       ) : mng_memalloc;      stdcall;
function  mng_getcb_memfree       (    hHandle      : mng_handle       ) : mng_memfree;       stdcall;

function  mng_getcb_openstream    (    hHandle      : mng_handle       ) : mng_openstream;    stdcall;
function  mng_getcb_closestream   (    hHandle      : mng_handle       ) : mng_closestream;   stdcall;

function  mng_getcb_readdata      (    hHandle      : mng_handle       ) : mng_readdata;      stdcall;

function  mng_getcb_writedata     (    hHandle      : mng_handle       ) : mng_writedata;     stdcall;

function  mng_getcb_errorproc     (    hHandle      : mng_handle       ) : mng_errorproc;     stdcall;
function  mng_getcb_traceproc     (    hHandle      : mng_handle       ) : mng_traceproc;     stdcall;

function  mng_getcb_processheader (    hHandle      : mng_handle       ) : mng_processheader; stdcall;
function  mng_getcb_processtext   (    hHandle      : mng_handle       ) : mng_processtext;   stdcall;

function  mng_getcb_getcanvasline (    hHandle      : mng_handle       ) : mng_getcanvasline; stdcall;
function  mng_getcb_getbkgdline   (    hHandle      : mng_handle       ) : mng_getbkgdline;   stdcall;
function  mng_getcb_refresh       (    hHandle      : mng_handle       ) : mng_refresh;       stdcall;

function  mng_getcb_gettickcount  (    hHandle      : mng_handle       ) : mng_gettickcount;  stdcall;
function  mng_getcb_settimer      (    hHandle      : mng_handle       ) : mng_settimer;      stdcall;

function  mng_getcb_processgamma  (    hHandle      : mng_handle       ) : mng_processgamma;  stdcall;
function  mng_getcb_processchroma (    hHandle      : mng_handle       ) : mng_processchroma; stdcall;
function  mng_getcb_processsrgb   (    hHandle      : mng_handle       ) : mng_processsrgb;   stdcall;
function  mng_getcb_processiccp   (    hHandle      : mng_handle       ) : mng_processiccp;   stdcall;
function  mng_getcb_processarow   (    hHandle      : mng_handle       ) : mng_processarow;   stdcall;

{****************************************************************************}

function  mng_set_userdata        (    hHandle      : mng_handle;
                                       iUserdata    : mng_int32        ) : mng_retcode;       stdcall;

function  mng_set_canvasstyle     (    hHandle      : mng_handle;
                                       iStyle       : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_bkgdstyle       (    hHandle      : mng_handle;
                                       iStyle       : mng_uint32       ) : mng_retcode;       stdcall;

function  mng_set_bgcolor         (    hHandle      : mng_handle;
                                       iRed         : mng_uint16;
                                       iGreen       : mng_uint16;
                                       iBlue        : mng_uint16       ) : mng_retcode;       stdcall;

function  mng_set_storechunks     (    hHandle      : mng_handle;
                                       bStorechunks : mng_bool         ) : mng_retcode;       stdcall;

function  mng_set_viewgammaint    (    hHandle      : mng_handle;
                                       iGamma       : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_displaygammaint (    hHandle      : mng_handle;
                                       iGamma       : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_dfltimggammaint (    hHandle      : mng_handle;
                                       iGamma       : mng_uint32       ) : mng_retcode;       stdcall;

function  mng_set_srgb            (    hHandle      : mng_handle;
                                       bIssRGB      : mng_bool         ) : mng_retcode;       stdcall;
function  mng_set_outputprofile   (    hHandle      : mng_handle;
                                       zFilename    : mng_pchar        ) : mng_retcode;       stdcall;
function  mng_set_outputprofile2  (    hHandle      : mng_handle;
                                       iProfilesize : mng_uint32;
                                       pProfile     : mng_ptr          ) : mng_retcode;       stdcall;
function  mng_set_srgbprofile     (    hHandle      : mng_handle;
                                       zFilename    : mng_pchar        ) : mng_retcode;       stdcall;
function  mng_set_srgbprofile2    (    hHandle      : mng_handle;
                                       iProfilesize : mng_uint32;
                                       pProfile     : mng_ptr          ) : mng_retcode;       stdcall;

function  mng_set_maxcanvaswidth  (    hHandle      : mng_handle;
                                       iMaxwidth    : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_maxcanvasheight (    hHandle      : mng_handle;
                                       iMaxheight   : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_maxcanvassize   (    hHandle      : mng_handle;
                                       iMaxwidth    : mng_uint32;
                                       iMaxheight   : mng_uint32       ) : mng_retcode;       stdcall;

{****************************************************************************}

function  mng_get_userdata        (    hHandle      : mng_handle       ) : mng_int32;         stdcall;

function  mng_get_sigtype         (    hHandle      : mng_handle       ) : mng_imgtype;       stdcall;
function  mng_get_imagetype       (    hHandle      : mng_handle       ) : mng_imgtype;       stdcall;
function  mng_get_imagewidth      (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_imageheight     (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_ticks           (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_framecount      (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_layercount      (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_playtime        (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_simplicity      (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;

function  mng_get_canvasstyle     (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_bkgdstyle       (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;

procedure mng_get_bgcolor         (    hHandle      : mng_handle;
                                   var iRed         : mng_uint16;
                                   var iGreen       : mng_uint16;
                                   var iBlue        : mng_uint16       );                     stdcall;

function  mng_get_storechunks     (    hHandle      : mng_handle       ) : mng_bool;          stdcall;

function  mng_get_viewgammaint    (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_displaygammaint (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_dfltimggammaint (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;

function  mng_get_srgb            (    hHandle      : mng_handle       ) : mng_bool;          stdcall;

function  mng_get_maxcanvaswidth  (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_maxcanvasheight (    hHandle      : mng_handle       ) : mng_uint32;        stdcall;

{****************************************************************************}

function  mng_iterate_chunks      (    hHandle      : mng_handle;
                                       iChunkseq    : mng_uint32;
                                       fProc        : mng_iteratechunk ) : mng_retcode;       stdcall;

{****************************************************************************}

function  mng_getchunk_ihdr       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iWidth             : mng_uint32;
                                   var iHeight            : mng_uint32;
                                   var iBitdepth          : mng_uint8;
                                   var iColortype         : mng_uint8;
                                   var iCompression       : mng_uint8;
                                   var iFilter            : mng_uint8;
                                   var iInterlace         : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_plte       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iCount             : mng_uint32;
                                   var aPalette           : mng_palette8 ) : mng_retcode; stdcall;

function  mng_getchunk_idat       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iRawlen            : mng_uint32;
                                   var pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_getchunk_trns       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var bGlobal            : mng_bool;
                                   var iType              : mng_uint8;
                                   var iCount             : mng_uint32;
                                   var aAlphas            : mng_uint8arr;
                                   var iGray              : mng_uint16;
                                   var iRed               : mng_uint16;
                                   var iGreen             : mng_uint16;
                                   var iBlue              : mng_uint16;
                                   var iRawlen            : mng_uint32;
                                   var aRawdata           : mng_uint8arr ) : mng_retcode; stdcall;

function  mng_getchunk_gama       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iGamma             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_chrm       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iWhitepointx       : mng_uint32;
                                   var iWhitepointy       : mng_uint32;
                                   var iRedx              : mng_uint32;
                                   var iRedy              : mng_uint32;
                                   var iGreenx            : mng_uint32;
                                   var iGreeny            : mng_uint32;
                                   var iBluex             : mng_uint32;
                                   var iBluey             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_srgb       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iRenderingintent   : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_iccp       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iNamesize          : mng_uint32;
                                   var zName              : mng_pchar;
                                   var iCompression       : mng_uint8;
                                   var iProfilesize       : mng_uint32;
                                   var pProfile           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_getchunk_text       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iKeywordsize       : mng_uint32;
                                   var zKeyword           : mng_pchar;
                                   var iTextsize          : mng_uint32;
                                   var zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_ztxt       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iKeywordsize       : mng_uint32;
                                   var zKeyword           : mng_pchar;
                                   var iCompression       : mng_uint8;
                                   var iTextsize          : mng_uint32;
                                   var zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_itxt       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iKeywordsize       : mng_uint32;
                                   var zKeyword           : mng_pchar;
                                   var iCompressionflag   : mng_uint8;
                                   var iCompressionmethod : mng_uint8;
                                   var iLanguagesize      : mng_uint32;
                                   var zLanguage          : mng_pchar;
                                   var iTranslationsize   : mng_uint32;
                                   var zTranslation       : mng_pchar;
                                   var iTextsize          : mng_uint32;
                                   var zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_bkgd       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iType              : mng_uint8;
                                   var iIndex             : mng_uint8;
                                   var iGray              : mng_uint16;
                                   var iRed               : mng_uint16;
                                   var iGreen             : mng_uint16;
                                   var iBlue              : mng_uint16   ) : mng_retcode; stdcall;

function  mng_getchunk_phys       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iSizex             : mng_uint32;
                                   var iSizey             : mng_uint32;
                                   var iUnit              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_sbit       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iType              : mng_uint8;
                                   var aBits              : mng_uint8arr4) : mng_retcode; stdcall;

function  mng_getchunk_splt       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iNamesize          : mng_uint32;
                                   var zName              : mng_pchar;
                                   var iSampledepth       : mng_uint8;
                                   var iEntrycount        : mng_uint32;
                                   var pEntries           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_getchunk_hist       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iEntrycount        : mng_uint32;
                                   var aEntries           : mng_uint16arr) : mng_retcode; stdcall;

function  mng_getchunk_time       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iYear              : mng_uint16;
                                   var iMonth             : mng_uint8;
                                   var iDay               : mng_uint8;
                                   var iHour              : mng_uint8;
                                   var iMinute            : mng_uint8;
                                   var iSecond            : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_mhdr       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iWidth             : mng_uint32;
                                   var iHeight            : mng_uint32;
                                   var iTicks             : mng_uint32;
                                   var iLayercount        : mng_uint32;
                                   var iFramecount        : mng_uint32;
                                   var iPlaytime          : mng_uint32;
                                   var iSimplicity        : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_loop       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iLevel             : mng_uint8;
                                   var iRepeat            : mng_uint32;
                                   var iTermination       : mng_uint8;
                                   var iItermin           : mng_uint32;
                                   var iItermax           : mng_uint32;
                                   var iCount             : mng_uint32;
                                   var pSignals           : mng_uint32p  ) : mng_retcode; stdcall;

function  mng_getchunk_endl       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iLevel             : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_defi       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iObjectid          : mng_uint16;
                                   var iDonotshow         : mng_uint8;
                                   var iConcrete          : mng_uint8;
                                   var bHasloca           : mng_bool;
                                   var iXlocation         : mng_int32;
                                   var iYlocation         : mng_int32;
                                   var bHasclip           : mng_bool;
                                   var iLeftcb            : mng_int32;
                                   var iRightcb           : mng_int32;
                                   var iTopcb             : mng_int32;
                                   var iBottomcb          : mng_int32    ) : mng_retcode; stdcall;

function  mng_getchunk_basi       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iWidth             : mng_uint32;
                                   var iHeight            : mng_uint32;
                                   var iBitdepth          : mng_uint8;
                                   var iColortype         : mng_uint8;
                                   var iCompression       : mng_uint8;
                                   var iFilter            : mng_uint8;
                                   var iInterlace         : mng_uint8;
                                   var iRed               : mng_uint16;
                                   var iGreen             : mng_uint16;
                                   var iBlue              : mng_uint16;
                                   var iAlpha             : mng_uint16;
                                   var iViewable          : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_clon       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iSourceid          : mng_uint16;
                                   var iCloneid           : mng_uint16;
                                   var iClonetype         : mng_uint8;
                                   var iDonotshow         : mng_uint8;
                                   var iConcrete          : mng_uint8;
                                   var bHasloca           : mng_bool;
                                   var iLocationtype      : mng_uint8;
                                   var iLocationx         : mng_int32;
                                   var iLocationy         : mng_int32    ) : mng_retcode; stdcall;

function  mng_getchunk_past       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iDestid            : mng_uint16;
                                   var iTargettype        : mng_uint8;
                                   var iTargetx           : mng_int32;
                                   var iTargety           : mng_int32;
                                   var iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_past_src   (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                       iEntry             : mng_uint32;
                                   var iSourceid          : mng_uint16;
                                   var iComposition       : mng_uint8;
                                   var iOrientation       : mng_uint8;
                                   var iOffsettype        : mng_uint8;
                                   var iOffsetx           : mng_int32;
                                   var iOffsety           : mng_int32;
                                   var iBoundarytype      : mng_uint8;
                                   var iBoundaryl         : mng_int32;
                                   var iBoundaryr         : mng_int32;
                                   var iBoundaryt         : mng_int32;
                                   var iBoundaryb         : mng_int32    ) : mng_retcode; stdcall;

function  mng_getchunk_disc       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iCount             : mng_uint32;
                                   var pObjectids         : mng_uint16p  ) : mng_retcode; stdcall;

function  mng_getchunk_back       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iRed               : mng_uint16;
                                   var iGreen             : mng_uint16;
                                   var iBlue              : mng_uint16;
                                   var iMandatory         : mng_uint8;
                                   var iImageid           : mng_uint16;
                                   var iTile              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_fram       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iMode              : mng_uint8;
                                   var iNamesize          : mng_uint32;
                                   var zName              : mng_pchar;
                                   var iChangedelay       : mng_uint8;
                                   var iChangetimeout     : mng_uint8;
                                   var iChangeclipping    : mng_uint8;
                                   var iChangesyncid      : mng_uint8;
                                   var iDelay             : mng_uint32;
                                   var iTimeout           : mng_uint32;
                                   var iBoundarytype      : mng_uint8;
                                   var iBoundaryl         : mng_int32;
                                   var iBoundaryr         : mng_int32;
                                   var iBoundaryt         : mng_int32;
                                   var iBoundaryb         : mng_int32;
                                   var iCount             : mng_uint32;
                                   var pSyncids           : mng_uint32p  ) : mng_retcode; stdcall;

function  mng_getchunk_move       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iFirstid           : mng_uint16;
                                   var iLastid            : mng_uint16;
                                   var iMovetype          : mng_uint8;
                                   var iMovex             : mng_int32;
                                   var iMovey             : mng_int32    ) : mng_retcode; stdcall;

function  mng_getchunk_clip       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iFirstid           : mng_uint16;
                                   var iLastid            : mng_uint16;
                                   var iCliptype          : mng_uint8;
                                   var iClipl             : mng_int32;
                                   var iClipr             : mng_int32;
                                   var iClipt             : mng_int32;
                                   var iClipb             : mng_int32    ) : mng_retcode; stdcall;

function  mng_getchunk_show       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iFirstid           : mng_uint16;
                                   var iLastid            : mng_uint16;
                                   var iMode              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_term       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iTermaction        : mng_uint8;
                                   var iIteraction        : mng_uint8;
                                   var iDelay             : mng_uint32;
                                   var iItermax           : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_save       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iOffsettype        : mng_uint8;
                                   var iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_save_entry (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                       iEntry             : mng_uint32;
                                   var iEntrytype         : mng_uint8;
                                   var iOffset            : mng_uint32arr2;
                                   var iStarttime         : mng_uint32arr2;
                                   var iLayernr           : mng_uint32;
                                   var iFramenr           : mng_uint32;
                                   var iNamesize          : mng_uint32;
                                   var zName              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_seek       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iNamesize          : mng_uint32;
                                   var zName              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_expi       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iSnapshotid        : mng_uint16;
                                   var iNamesize          : mng_uint32;
                                   var zName              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_fpri       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iDeltatype         : mng_uint8;
                                   var iPriority          : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_need       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iKeywordssize      : mng_uint32;
                                   var zKeywords          : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_phyg       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var bEmpty             : mng_bool;
                                   var iSizex             : mng_uint32;
                                   var iSizey             : mng_uint32;
                                   var iUnit              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_jhdr       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iWidth             : mng_uint32;
                                   var iHeight            : mng_uint32;
                                   var iColortype         : mng_uint8;
                                   var iImagesampledepth  : mng_uint8;
                                   var iImagecompression  : mng_uint8;
                                   var iImageinterlace    : mng_uint8;
                                   var iAlphasampledepth  : mng_uint8;
                                   var iAlphacompression  : mng_uint8;
                                   var iAlphafilter       : mng_uint8;
                                   var iAlphainterlace    : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_jdat       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iRawlen            : mng_uint32;
                                   var pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_getchunk_dhdr       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iObjectid          : mng_uint16;
                                   var iImagetype         : mng_uint8;
                                   var iDeltatype         : mng_uint8;
                                   var iBlockwidth        : mng_uint32;
                                   var iBlockheight       : mng_uint32;
                                   var iBlockx            : mng_uint32;
                                   var iBlocky            : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_prom       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iColortype         : mng_uint8;
                                   var iSampledepth       : mng_uint8;
                                   var iFilltype          : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_pplt       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_pplt_entry (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                       iEntry             : mng_uint32;
                                   var iRed               : mng_uint16;
                                   var iGreen             : mng_uint16;
                                   var iBlue              : mng_uint16;
                                   var iAlpha             : mng_uint16;
                                   var bUsed              : mng_bool     ) : mng_retcode; stdcall;

function  mng_getchunk_drop       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iCount             : mng_uint32;
                                   var pChunknames        : mng_chunkidp ) : mng_retcode; stdcall;

function  mng_getchunk_dbyk       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iChunkname         : mng_chunkid;
                                   var iPolarity          : mng_uint8;
                                   var iKeywordssize      : mng_uint32;
                                   var zKeywords          : mng_pchar    ) : mng_retcode; stdcall;

function  mng_getchunk_ordr       (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_getchunk_ordr_entry (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                       iEntry             : mng_uint32;
                                   var iChunkname         : mng_chunkid;
                                   var iOrdertype         : mng_uint8    ) : mng_retcode; stdcall;

function  mng_getchunk_unknown    (    hHandle            : mng_handle;
                                       hChunk             : mng_handle;
                                   var iChunkname         : mng_chunkid;
                                   var iRawlen            : mng_uint32;
                                   var pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

{****************************************************************************}

function  mng_putchunk_ihdr       (    hHandle            : mng_handle;
                                       iWidth             : mng_uint32;
                                       iHeight            : mng_uint32;
                                       iBitdepth          : mng_uint8;
                                       iColortype         : mng_uint8;
                                       iCompression       : mng_uint8;
                                       iFilter            : mng_uint8;
                                       iInterlace         : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_plte       (    hHandle            : mng_handle;
                                       iCount             : mng_uint32;
                                       aPalette           : mng_palette8 ) : mng_retcode; stdcall;

function  mng_putchunk_idat       (    hHandle            : mng_handle;
                                       iRawlen            : mng_uint32;
                                       pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_trns       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       bGlobal            : mng_bool;
                                       iType              : mng_uint8;
                                       iCount             : mng_uint32;
                                       aAlphas            : mng_uint8arr;
                                       iGray              : mng_uint16;
                                       iRed               : mng_uint16;
                                       iGreen             : mng_uint16;
                                       iBlue              : mng_uint16;
                                       iRawlen            : mng_uint32;
                                       aRawdata           : mng_uint8arr ) : mng_retcode; stdcall;

function  mng_putchunk_gama       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iGamma             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_chrm       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iWhitepointx       : mng_uint32;
                                       iWhitepointy       : mng_uint32;
                                       iRedx              : mng_uint32;
                                       iRedy              : mng_uint32;
                                       iGreenx            : mng_uint32;
                                       iGreeny            : mng_uint32;
                                       iBluex             : mng_uint32;
                                       iBluey             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_srgb       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iRenderingintent   : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_iccp       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iNamesize          : mng_uint32;
                                       zName              : mng_pchar;
                                       iCompression       : mng_uint8;
                                       iProfilesize       : mng_uint32;
                                       pProfile           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_text       (    hHandle            : mng_handle;
                                       iKeywordsize       : mng_uint32;
                                       zKeyword           : mng_pchar;
                                       iTextsize          : mng_uint32;
                                       zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_ztxt       (    hHandle            : mng_handle;
                                       iKeywordsize       : mng_uint32;
                                       zKeyword           : mng_pchar;
                                       iCompression       : mng_uint8;
                                       iTextsize          : mng_uint32;
                                       zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_itxt       (    hHandle            : mng_handle;
                                       iKeywordsize       : mng_uint32;
                                       zKeyword           : mng_pchar;
                                       iCompressionflag   : mng_uint8;
                                       iCompressionmethod : mng_uint8;
                                       iLanguagesize      : mng_uint32;
                                       zLanguage          : mng_pchar;
                                       iTranslationsize   : mng_uint32;
                                       zTranslation       : mng_pchar;
                                       iTextsize          : mng_uint32;
                                       zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_bkgd       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iType              : mng_uint8;
                                       iIndex             : mng_uint8;
                                       iGray              : mng_uint16;
                                       iRed               : mng_uint16;
                                       iGreen             : mng_uint16;
                                       iBlue              : mng_uint16   ) : mng_retcode; stdcall;

function  mng_putchunk_phys       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iSizex             : mng_uint32;
                                       iSizey             : mng_uint32;
                                       iUnit              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_sbit       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iType              : mng_uint8;
                                       aBits              : mng_uint8arr4) : mng_retcode; stdcall;

function  mng_putchunk_splt       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iNamesize          : mng_uint32;
                                       zName              : mng_pchar;
                                       iSampledepth       : mng_uint8;
                                       iEntrycount        : mng_uint32;
                                       pEntries           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_hist       (    hHandle            : mng_handle;
                                       iEntrycount        : mng_uint32;
                                       aEntries           : mng_uint16arr) : mng_retcode; stdcall;

function  mng_putchunk_time       (    hHandle            : mng_handle;
                                       iYear              : mng_uint16;
                                       iMonth             : mng_uint8;
                                       iDay               : mng_uint8;
                                       iHour              : mng_uint8;
                                       iMinute            : mng_uint8;
                                       iSecond            : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_mhdr       (    hHandle            : mng_handle;
                                       iWidth             : mng_uint32;
                                       iHeight            : mng_uint32;
                                       iTicks             : mng_uint32;
                                       iLayercount        : mng_uint32;
                                       iFramecount        : mng_uint32;
                                       iPlaytime          : mng_uint32;
                                       iSimplicity        : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_loop       (    hHandle            : mng_handle;
                                       iLevel             : mng_uint8;
                                       iRepeat            : mng_uint32;
                                       iTermination       : mng_uint8;
                                       iItermin           : mng_uint32;
                                       iItermax           : mng_uint32;
                                       iCount             : mng_uint32;
                                       pSignals           : mng_uint32p  ) : mng_retcode; stdcall;

function  mng_putchunk_endl       (    hHandle            : mng_handle;
                                       iLevel             : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_defi       (    hHandle            : mng_handle;
                                       iObjectid          : mng_uint16;
                                       iDonotshow         : mng_uint8;
                                       iConcrete          : mng_uint8;
                                       bHasloca           : mng_bool;
                                       iXlocation         : mng_int32;
                                       iYlocation         : mng_int32;
                                       bHasclip           : mng_bool;
                                       iLeftcb            : mng_int32;
                                       iRightcb           : mng_int32;
                                       iTopcb             : mng_int32;
                                       iBottomcb          : mng_int32    ) : mng_retcode; stdcall;

function  mng_putchunk_basi       (    hHandle            : mng_handle;
                                       iWidth             : mng_uint32;
                                       iHeight            : mng_uint32;
                                       iBitdepth          : mng_uint8;
                                       iColortype         : mng_uint8;
                                       iCompression       : mng_uint8;
                                       iFilter            : mng_uint8;
                                       iInterlace         : mng_uint8;
                                       iRed               : mng_uint16;
                                       iGreen             : mng_uint16;
                                       iBlue              : mng_uint16;
                                       iAlpha             : mng_uint16;
                                       iViewable          : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_clon       (    hHandle            : mng_handle;
                                       iSourceid          : mng_uint16;
                                       iCloneid           : mng_uint16;
                                       iClonetype         : mng_uint8;
                                       iDonotshow         : mng_uint8;
                                       iConcrete          : mng_uint8;
                                       bHasloca           : mng_bool;
                                       iLocationtype      : mng_uint8;
                                       iLocationx         : mng_int32;
                                       iLocationy         : mng_int32    ) : mng_retcode; stdcall;

function  mng_putchunk_past       (    hHandle            : mng_handle;
                                       iDestid            : mng_uint16;
                                       iTargettype        : mng_uint8;
                                       iTargetx           : mng_int32;
                                       iTargety           : mng_int32;
                                       iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_past_src   (    hHandle            : mng_handle;
                                       iEntry             : mng_uint32;
                                       iSourceid          : mng_uint16;
                                       iComposition       : mng_uint8;
                                       iOrientation       : mng_uint8;
                                       iOffsettype        : mng_uint8;
                                       iOffsetx           : mng_int32;
                                       iOffsety           : mng_int32;
                                       iBoundarytype      : mng_uint8;
                                       iBoundaryl         : mng_int32;
                                       iBoundaryr         : mng_int32;
                                       iBoundaryt         : mng_int32;
                                       iBoundaryb         : mng_int32    ) : mng_retcode; stdcall;

function  mng_putchunk_disc       (    hHandle            : mng_handle;
                                       iCount             : mng_uint32;
                                       pObjectids         : mng_uint16p  ) : mng_retcode; stdcall;

function  mng_putchunk_back       (    hHandle            : mng_handle;
                                       iRed               : mng_uint16;
                                       iGreen             : mng_uint16;
                                       iBlue              : mng_uint16;
                                       iMandatory         : mng_uint8;
                                       iImageid           : mng_uint16;
                                       iTile              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_fram       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iMode              : mng_uint8;
                                       iNamesize          : mng_uint32;
                                       zName              : mng_pchar;
                                       iChangedelay       : mng_uint8;
                                       iChangetimeout     : mng_uint8;
                                       iChangeclipping    : mng_uint8;
                                       iChangesyncid      : mng_uint8;
                                       iDelay             : mng_uint32;
                                       iTimeout           : mng_uint32;
                                       iBoundarytype      : mng_uint8;
                                       iBoundaryl         : mng_int32;
                                       iBoundaryr         : mng_int32;
                                       iBoundaryt         : mng_int32;
                                       iBoundaryb         : mng_int32;
                                       iCount             : mng_uint32;
                                       pSyncids           : mng_uint32p  ) : mng_retcode; stdcall;

function  mng_putchunk_move       (    hHandle            : mng_handle;
                                       iFirstid           : mng_uint16;
                                       iLastid            : mng_uint16;
                                       iMovetype          : mng_uint8;
                                       iMovex             : mng_int32;
                                       iMovey             : mng_int32    ) : mng_retcode; stdcall;

function  mng_putchunk_clip       (    hHandle            : mng_handle;
                                       iFirstid           : mng_uint16;
                                       iLastid            : mng_uint16;
                                       iCliptype          : mng_uint8;
                                       iClipl             : mng_int32;
                                       iClipr             : mng_int32;
                                       iClipt             : mng_int32;
                                       iClipb             : mng_int32    ) : mng_retcode; stdcall;

function  mng_putchunk_show       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iFirstid           : mng_uint16;
                                       iLastid            : mng_uint16;
                                       iMode              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_term       (    hHandle            : mng_handle;
                                       iTermaction        : mng_uint8;
                                       iIteraction        : mng_uint8;
                                       iDelay             : mng_uint32;
                                       iItermax           : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_save       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iOffsettype        : mng_uint8;
                                       iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_save_entry (    hHandle            : mng_handle;
                                       iEntry             : mng_uint32;
                                       iEntrytype         : mng_uint8;
                                       iOffset            : mng_uint32arr2;
                                       iStarttime         : mng_uint32arr2;
                                       iLayernr           : mng_uint32;
                                       iFramenr           : mng_uint32;
                                       iNamesize          : mng_uint32;
                                       zName              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_seek       (    hHandle            : mng_handle;
                                       iNamesize          : mng_uint32;
                                       zName              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_expi       (    hHandle            : mng_handle;
                                       iSnapshotid        : mng_uint16;
                                       iNamesize          : mng_uint32;
                                       zName              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_fpri       (    hHandle            : mng_handle;
                                       iDeltatype         : mng_uint8;
                                       iPriority          : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_need       (    hHandle            : mng_handle;
                                       iKeywordssize      : mng_uint32;
                                       zKeywords          : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_phyg       (    hHandle            : mng_handle;
                                       bEmpty             : mng_bool;
                                       iSizex             : mng_uint32;
                                       iSizey             : mng_uint32;
                                       iUnit              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_jhdr       (    hHandle            : mng_handle;
                                       iWidth             : mng_uint32;
                                       iHeight            : mng_uint32;
                                       iColortype         : mng_uint8;
                                       iImagesampledepth  : mng_uint8;
                                       iImagecompression  : mng_uint8;
                                       iImageinterlace    : mng_uint8;
                                       iAlphasampledepth  : mng_uint8;
                                       iAlphacompression  : mng_uint8;
                                       iAlphafilter       : mng_uint8;
                                       iAlphainterlace    : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_jdat       (    hHandle            : mng_handle;
                                       iRawlen            : mng_uint32;
                                       pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_dhdr       (    hHandle            : mng_handle;
                                       iObjectid          : mng_uint16;
                                       iImagetype         : mng_uint8;
                                       iDeltatype         : mng_uint8;
                                       iBlockwidth        : mng_uint32;
                                       iBlockheight       : mng_uint32;
                                       iBlockx            : mng_uint32;
                                       iBlocky            : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_prom       (    hHandle            : mng_handle;
                                       iColortype         : mng_uint8;
                                       iSampledepth       : mng_uint8;
                                       iFilltype          : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_pplt       (    hHandle            : mng_handle;
                                       iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_pplt_entry (    hHandle            : mng_handle;
                                       iEntry             : mng_uint32;
                                       iRed               : mng_uint16;
                                       iGreen             : mng_uint16;
                                       iBlue              : mng_uint16;
                                       iAlpha             : mng_uint16;
                                       bUsed              : mng_bool     ) : mng_retcode; stdcall;

function  mng_putchunk_drop       (    hHandle            : mng_handle;
                                       iCount             : mng_uint32;
                                       pChunknames        : mng_chunkidp ) : mng_retcode; stdcall;

function  mng_putchunk_dbyk       (    hHandle            : mng_handle;
                                       iChunkname         : mng_chunkid;
                                       iPolarity          : mng_uint8;
                                       iKeywordssize      : mng_uint32;
                                       zKeywords          : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_ordr       (    hHandle            : mng_handle;
                                       iCount             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_ordr_entry (    hHandle            : mng_handle;
                                       iEntry             : mng_uint32;
                                       iChunkname         : mng_chunkid;
                                       iOrdertype         : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_unknown    (    hHandle            : mng_handle;
                                       iChunkname         : mng_chunkid;
                                       iRawlen            : mng_uint32;
                                       pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

{****************************************************************************}

const MNG_CANVAS_RGB8      = $00000000;
      MNG_CANVAS_RGB16     = $00000100;          { not supported yet }
      MNG_CANVAS_RGBA8     = $00001000;
      MNG_CANVAS_RGBA16    = $00001100;          { not supported yet }
      MNG_CANVAS_ARGB8     = $00003000;
      MNG_CANVAS_ARGB16    = $00003100;          { not supported yet }
      MNG_CANVAS_BGR8      = $00000001;
      MNG_CANVAS_BGR16     = $00000101;          { not supported yet }
      MNG_CANVAS_BGRA8     = $00001001;
      MNG_CANVAS_BGRA16    = $00001101;          { not supported yet }
      MNG_CANVAS_ABGR8     = $00003001;
      MNG_CANVAS_ABGR16    = $00003101;          { not supported yet }
      MNG_CANVAS_GRAY8     = $00000002;          { not supported yet }
      MNG_CANVAS_GRAY16    = $00000102;          { not supported yet }
      MNG_CANVAS_GRAYA8    = $00001002;          { not supported yet }
      MNG_CANVAS_GRAYA16   = $00001102;          { not supported yet }
      MNG_CANVAS_AGRAY8    = $00003002;          { not supported yet }
      MNG_CANVAS_AGRAY16   = $00003102;          { not supported yet }
      MNG_CANVAS_DX15      = $00000003;          { not supported yet }
      MNG_CANVAS_DX16      = $00000004;          { not supported yet }

{****************************************************************************}

const MNG_UINT_HUH  = $40404040;

      MNG_UINT_BACK = $4241434b;
      MNG_UINT_BASI = $42415349;
      MNG_UINT_CLIP = $434c4950;
      MNG_UINT_CLON = $434c4f4e;
      MNG_UINT_DBYK = $4442594b;
      MNG_UINT_DEFI = $44454649;
      MNG_UINT_DHDR = $44484452;
      MNG_UINT_DISC = $44495343;
      MNG_UINT_DROP = $44524f50;
      MNG_UINT_ENDL = $454e444c;
      MNG_UINT_FRAM = $4652414d;
      MNG_UINT_IDAT = $49444154;
      MNG_UINT_IEND = $49454e44;
      MNG_UINT_IHDR = $49484452;
      MNG_UINT_IJNG = $494a4e47;
      MNG_UINT_IPNG = $49504e47;
      MNG_UINT_JDAT = $4a444154;
      MNG_UINT_JHDR = $4a484452;
      MNG_UINT_JSEP = $4a534550;
      MNG_UINT_LOOP = $4c4f4f50;
      MNG_UINT_MEND = $4d454e44;
      MNG_UINT_MHDR = $4d484452;
      MNG_UINT_MOVE = $4d4f5645;
      MNG_UINT_ORDR = $4f524452;
      MNG_UINT_PAST = $50415354;
      MNG_UINT_PLTE = $504c5445;
      MNG_UINT_PPLT = $50504c54;
      MNG_UINT_PROM = $50524f4d;
      MNG_UINT_SAVE = $53415645;
      MNG_UINT_SEEK = $5345454b;
      MNG_UINT_SHOW = $53484f57;
      MNG_UINT_TERM = $5445524d;
      MNG_UINT_bKGD = $624b4744;
      MNG_UINT_cHRM = $6348524d;
      MNG_UINT_eXPI = $65585049;
      MNG_UINT_fPRI = $66505249;
      MNG_UINT_gAMA = $67414d41;
      MNG_UINT_hIST = $68495354;
      MNG_UINT_iCCP = $69434350;
      MNG_UINT_iTXt = $69545874;
      MNG_UINT_nEED = $6e454544;
      MNG_UINT_oFFs = $6f464673;
      MNG_UINT_pCAL = $7043414c;
      MNG_UINT_pHYg = $49444167;
      MNG_UINT_pHYs = $70485973;
      MNG_UINT_sBIT = $73424954;
      MNG_UINT_sCAL = $7343414c;
      MNG_UINT_sPLT = $73504c54;
      MNG_UINT_sRGB = $73524742;
      MNG_UINT_tEXt = $74455874;
      MNG_UINT_tIME = $74494d45;
      MNG_UINT_tRNS = $74524e53;
      MNG_UINT_zTXt = $7a545874;

{****************************************************************************}

function mng_errorname    (iErrcode  : mng_int32 ) : string;
function mng_functionname (iFunction : mng_int32 ) : string;
function mng_locationname (iLocation : mng_uint32) : string;

{****************************************************************************}

implementation

{****************************************************************************}

const mngdll = 'libmng.dll';

{****************************************************************************}

function mng_initialize;           external mngdll;
function mng_reset;                external mngdll;
function mng_cleanup;              external mngdll;

function mng_read;                 external mngdll;
function mng_write;                external mngdll;
function mng_create;               external mngdll;

function mng_readdisplay;          external mngdll;
function mng_display;              external mngdll;
function mng_display_resume;       external mngdll;
function mng_display_freeze;       external mngdll;
function mng_display_reset;        external mngdll;
function mng_display_goframe;      external mngdll;
function mng_display_golayer;      external mngdll;
function mng_display_gotime;       external mngdll;

function mng_getlasterror;         external mngdll;

{****************************************************************************}

function mng_setcb_memalloc;       external mngdll;
function mng_setcb_memfree;        external mngdll;

function mng_setcb_openstream;     external mngdll;
function mng_setcb_closestream;    external mngdll;

function mng_setcb_readdata;       external mngdll;

function mng_setcb_writedata;      external mngdll;

function mng_setcb_errorproc;      external mngdll;
function mng_setcb_traceproc;      external mngdll;

function mng_setcb_processheader;  external mngdll;
function mng_setcb_processtext;    external mngdll;

function mng_setcb_getcanvasline;  external mngdll;
function mng_setcb_getbkgdline;    external mngdll;
function mng_setcb_refresh;        external mngdll;

function mng_setcb_gettickcount;   external mngdll;
function mng_setcb_settimer;       external mngdll;

function mng_setcb_processgamma;   external mngdll;
function mng_setcb_processchroma;  external mngdll;
function mng_setcb_processsrgb;    external mngdll;
function mng_setcb_processiccp;    external mngdll;
function mng_setcb_processarow;    external mngdll;

{****************************************************************************}

function mng_getcb_memalloc;       external mngdll;
function mng_getcb_memfree;        external mngdll;

function mng_getcb_openstream;     external mngdll;
function mng_getcb_closestream;    external mngdll;

function mng_getcb_readdata;       external mngdll;

function mng_getcb_writedata;      external mngdll;

function mng_getcb_errorproc;      external mngdll;
function mng_getcb_traceproc;      external mngdll;

function mng_getcb_processheader;  external mngdll;
function mng_getcb_processtext;    external mngdll;

function mng_getcb_getcanvasline;  external mngdll;
function mng_getcb_getbkgdline;    external mngdll;
function mng_getcb_refresh;        external mngdll;

function mng_getcb_gettickcount;   external mngdll;
function mng_getcb_settimer;       external mngdll;

function mng_getcb_processgamma;   external mngdll;
function mng_getcb_processchroma;  external mngdll;
function mng_getcb_processsrgb;    external mngdll;
function mng_getcb_processiccp;    external mngdll;
function mng_getcb_processarow;    external mngdll;

{****************************************************************************}

function mng_set_userdata;         external mngdll;

function mng_set_canvasstyle;      external mngdll;
function mng_set_bkgdstyle;        external mngdll;

function mng_set_bgcolor;          external mngdll;

function mng_set_storechunks;      external mngdll;

// function mng_set_viewgamma;        external mngdll;
// function mng_set_displaygamma;     external mngdll;
// function mng_set_dfltimggamma;     external mngdll;
function mng_set_viewgammaint;     external mngdll;
function mng_set_displaygammaint;  external mngdll;
function mng_set_dfltimggammaint;  external mngdll;

function mng_set_srgb;             external mngdll;
function mng_set_outputprofile;    external mngdll;
function mng_set_outputprofile2;   external mngdll;
function mng_set_srgbprofile;      external mngdll;
function mng_set_srgbprofile2;     external mngdll;

function mng_set_maxcanvaswidth;   external mngdll;
function mng_set_maxcanvasheight;  external mngdll;
function mng_set_maxcanvassize;    external mngdll;

{****************************************************************************}

function  mng_get_userdata;        external mngdll;

function  mng_get_sigtype;         external mngdll;
function  mng_get_imagetype;       external mngdll;
function  mng_get_imagewidth;      external mngdll;
function  mng_get_imageheight;     external mngdll;
function  mng_get_ticks;           external mngdll;
function  mng_get_framecount;      external mngdll;
function  mng_get_layercount;      external mngdll;
function  mng_get_playtime;        external mngdll;
function  mng_get_simplicity;      external mngdll;

function  mng_get_canvasstyle;     external mngdll;
function  mng_get_bkgdstyle;       external mngdll;

procedure mng_get_bgcolor;         external mngdll;

function  mng_get_storechunks;     external mngdll;

// function  mng_get_viewgamma;       external mngdll;
// function  mng_get_displaygamma;    external mngdll;
// function  mng_get_dfltimggamma;    external mngdll;
function  mng_get_viewgammaint;    external mngdll;
function  mng_get_displaygammaint; external mngdll;
function  mng_get_dfltimggammaint; external mngdll;

function  mng_get_srgb;            external mngdll;

function  mng_get_maxcanvaswidth;  external mngdll;
function  mng_get_maxcanvasheight; external mngdll;

{****************************************************************************}

function  mng_iterate_chunks;      external mngdll;

{****************************************************************************}

function  mng_getchunk_ihdr;       external mngdll;
function  mng_getchunk_plte;       external mngdll;
function  mng_getchunk_idat;       external mngdll;
function  mng_getchunk_trns;       external mngdll;
function  mng_getchunk_gama;       external mngdll;
function  mng_getchunk_chrm;       external mngdll;
function  mng_getchunk_srgb;       external mngdll;
function  mng_getchunk_iccp;       external mngdll;
function  mng_getchunk_text;       external mngdll;
function  mng_getchunk_ztxt;       external mngdll;
function  mng_getchunk_itxt;       external mngdll;
function  mng_getchunk_bkgd;       external mngdll;
function  mng_getchunk_phys;       external mngdll;
function  mng_getchunk_sbit;       external mngdll;
function  mng_getchunk_splt;       external mngdll;
function  mng_getchunk_hist;       external mngdll;
function  mng_getchunk_time;       external mngdll;
function  mng_getchunk_mhdr;       external mngdll;
function  mng_getchunk_loop;       external mngdll;
function  mng_getchunk_endl;       external mngdll;
function  mng_getchunk_defi;       external mngdll;
function  mng_getchunk_basi;       external mngdll;
function  mng_getchunk_clon;       external mngdll;
function  mng_getchunk_past;       external mngdll;
function  mng_getchunk_past_src;   external mngdll;
function  mng_getchunk_disc;       external mngdll;
function  mng_getchunk_back;       external mngdll;
function  mng_getchunk_fram;       external mngdll;
function  mng_getchunk_move;       external mngdll;
function  mng_getchunk_clip;       external mngdll;
function  mng_getchunk_show;       external mngdll;
function  mng_getchunk_term;       external mngdll;
function  mng_getchunk_save;       external mngdll;
function  mng_getchunk_save_entry; external mngdll;
function  mng_getchunk_seek;       external mngdll;
function  mng_getchunk_expi;       external mngdll;
function  mng_getchunk_fpri;       external mngdll;
function  mng_getchunk_need;       external mngdll;
function  mng_getchunk_phyg;       external mngdll;
function  mng_getchunk_jhdr;       external mngdll;
function  mng_getchunk_jdat;       external mngdll;
function  mng_getchunk_dhdr;       external mngdll;
function  mng_getchunk_prom;       external mngdll;
function  mng_getchunk_pplt;       external mngdll;
function  mng_getchunk_pplt_entry; external mngdll;
function  mng_getchunk_drop;       external mngdll;
function  mng_getchunk_dbyk;       external mngdll;
function  mng_getchunk_ordr;       external mngdll;
function  mng_getchunk_ordr_entry; external mngdll;
function  mng_getchunk_unknown;    external mngdll;

{****************************************************************************}

function  mng_putchunk_ihdr;       external mngdll;
function  mng_putchunk_plte;       external mngdll;
function  mng_putchunk_idat;       external mngdll;
function  mng_putchunk_trns;       external mngdll;
function  mng_putchunk_gama;       external mngdll;
function  mng_putchunk_chrm;       external mngdll;
function  mng_putchunk_srgb;       external mngdll;
function  mng_putchunk_iccp;       external mngdll;
function  mng_putchunk_text;       external mngdll;
function  mng_putchunk_ztxt;       external mngdll;
function  mng_putchunk_itxt;       external mngdll;
function  mng_putchunk_bkgd;       external mngdll;
function  mng_putchunk_phys;       external mngdll;
function  mng_putchunk_sbit;       external mngdll;
function  mng_putchunk_splt;       external mngdll;
function  mng_putchunk_hist;       external mngdll;
function  mng_putchunk_time;       external mngdll;
function  mng_putchunk_mhdr;       external mngdll;
function  mng_putchunk_loop;       external mngdll;
function  mng_putchunk_endl;       external mngdll;
function  mng_putchunk_defi;       external mngdll;
function  mng_putchunk_basi;       external mngdll;
function  mng_putchunk_clon;       external mngdll;
function  mng_putchunk_past;       external mngdll;
function  mng_putchunk_past_src;   external mngdll;
function  mng_putchunk_disc;       external mngdll;
function  mng_putchunk_back;       external mngdll;
function  mng_putchunk_fram;       external mngdll;
function  mng_putchunk_move;       external mngdll;
function  mng_putchunk_clip;       external mngdll;
function  mng_putchunk_show;       external mngdll;
function  mng_putchunk_term;       external mngdll;
function  mng_putchunk_save;       external mngdll;
function  mng_putchunk_save_entry; external mngdll;
function  mng_putchunk_seek;       external mngdll;
function  mng_putchunk_expi;       external mngdll;
function  mng_putchunk_fpri;       external mngdll;
function  mng_putchunk_need;       external mngdll;
function  mng_putchunk_phyg;       external mngdll;
function  mng_putchunk_jhdr;       external mngdll;
function  mng_putchunk_jdat;       external mngdll;
function  mng_putchunk_dhdr;       external mngdll;
function  mng_putchunk_prom;       external mngdll;
function  mng_putchunk_pplt;       external mngdll;
function  mng_putchunk_pplt_entry; external mngdll;
function  mng_putchunk_drop;       external mngdll;
function  mng_putchunk_dbyk;       external mngdll;
function  mng_putchunk_ordr;       external mngdll;
function  mng_putchunk_ordr_entry; external mngdll;
function  mng_putchunk_unknown;    external mngdll;

{****************************************************************************}

function mng_errorname;
begin
  case iErrcode of
       0 : Result := 'NoError';
       1 : Result := 'OutOfMemory';
       2 : Result := 'InvalidHandle';
       3 : Result := 'NoCallback';
       4 : Result := 'UnexpectedEOF';
       5 : Result := 'ZlibError';
       6 : Result := 'JPEGError';
       7 : Result := 'LcmsError';
       8 : Result := 'NoOutputProfile';
       9 : Result := 'NoSRGBProfile';
      10 : Result := 'BufferOverflow';
      11 : Result := 'FunctionInvalid';
      12 : Result := 'OutputError';
      13 : Result := 'JPEGBufTooSmall';

     901 : Result := 'ApplicationIOError';
     902 : Result := 'ApplicationTimingError';
     903 : Result := 'ApplicationCMSError';
     904 : Result := 'ApplicationMiscError';
     905 : Result := 'ApplicationTraceAbort';

     999 : Result := 'InternalError';

    1025 : Result := 'InvalidSignature';
    1027 : Result := 'InvalidCRC';
    1028 : Result := 'InvalidLength';
    1029 : Result := 'SequenceError';
    1020 : Result := 'ChunkNotAllowed';
    1031 : Result := 'MultipleError';
    1032 : Result := 'PLTEMissing';
    1033 : Result := 'IDATMissing';
    1034 : Result := 'CannotBeEmpty';
    1035 : Result := 'GlobalLengthError';
    1036 : Result := 'InvalidBitDepth';
    1037 : Result := 'InvalidColorType';
    1038 : Result := 'InvalidCompressionMethod';
    1039 : Result := 'InvalidFilterMethod';
    1040 : Result := 'InvalidInterlaceMethod';
    1041 : Result := 'NotEnoughIDAT';
    1042 : Result := 'PLTEIndexError';
    1043 : Result := 'NullNotFound';
    1044 : Result := 'KeywordNull';
    1045 : Result := 'ObjectUnknown';
    1046 : Result := 'ObjectExists';
    1047 : Result := 'TooMuchIDAT';
    1048 : Result := 'InvalidSampleDepth';
    1049 : Result := 'InvalidOffsetSize';
    1050 : Result := 'InvalidEntryType';
    1051 : Result := 'EndsWithNull';
    1052 : Result := 'InvalidImageType';
    1053 : Result := 'InvalidDeltaType';
    1054 : Result := 'InvalidIndex';
    1055 : Result := 'TooMuchJDAT';
    1056 : Result := 'JPEGParmsError';

    2049 : Result := 'InvalidCanvasStyle';
    2050 : Result := 'WrongChunk';
    2051 : Result := 'InvalidEntryIndex';
    2052 : Result := 'NoHeader';
    2053 : Result := 'NoParentChunk';

    4097 : Result := 'ImageTooLarge';
    4098 : Result := 'NotAnAnimation';
    4099 : Result := 'FrameNrTooHigh';
    4100 : Result := 'LayerNrTooHigh';
    4101 : Result := 'PlayTimeTooHigh';
    4102 : Result := 'FunctionNotImplemented';

    8193 : Result := 'ImageFrozen';

  else     Result := '?????';
  end;     
end;

{****************************************************************************}

function mng_functionname;
begin
  case iFunction of
       1 : Result := 'Initialize';
       2 : Result := 'Reset';
       3 : Result := 'Cleanup';
       4 : Result := 'Read';
       5 : Result := 'Write';
       6 : Result := 'Create';
       7 : Result := 'ReadDisplay';
       8 : Result := 'Display';
       9 : Result := 'Display_Resume';
      10 : Result := 'Display_Freeze';
      11 : Result := 'Display_Reset';
      12 : Result := 'Display_GoFrame';
      13 : Result := 'Display_GoLayer';
      14 : Result := 'Display_GoTime';
      15 : Result := 'GetLastError';

     101 : Result := 'SetCB_MemAlloc';
     102 : Result := 'SetCB_MemFree';
     103 : Result := 'SetCB_ReadData';
     104 : Result := 'SetCB_WriteData';
     105 : Result := 'SetCB_ErrorProc';
     106 : Result := 'SetCB_TraceProc';
     107 : Result := 'SetCB_ProcessHeader';
     108 : Result := 'SetCB_ProcessText';
     109 : Result := 'SetCB_GetCanvasLine';
     110 : Result := 'SetCB_GetBkgdLine';
     111 : Result := 'SetCB_Refresh';
     112 : Result := 'SetCB_GetTickCount';
     113 : Result := 'SetCB_SetTimer';
     114 : Result := 'SetCB_ProcessGamma';
     115 : Result := 'SetCB_ProcessChroma';
     116 : Result := 'SetCB_ProcessSRGB';
     117 : Result := 'SetCB_ProcessICCP';
     118 : Result := 'SetCB_ProcessARow';
     119 : Result := 'SetCB_OpenStream';
     120 : Result := 'SetCB_CloseStream';

     201 : Result := 'GetCB_MemAlloc';
     202 : Result := 'GetCB_MemFree';
     203 : Result := 'GetCB_ReadData';
     204 : Result := 'GetCB_WriteData';
     205 : Result := 'GetCB_ErrorProc';
     206 : Result := 'GetCB_TraceProc';
     207 : Result := 'GetCB_ProcessHeader';
     208 : Result := 'GetCB_ProcessText';
     209 : Result := 'GetCB_GetCanvasLine';
     210 : Result := 'GetCB_GetBkgdLine';
     211 : Result := 'GetCB_Refresh';
     212 : Result := 'GetCB_GetTickCount';
     213 : Result := 'GetCB_SetTimer';
     214 : Result := 'GetCB_ProcessGamma';
     215 : Result := 'GetCB_ProcessChroma';
     216 : Result := 'GetCB_ProcessSRGB';
     217 : Result := 'GetCB_ProcessICCP';
     218 : Result := 'GetCB_ProcessARow';
     219 : Result := 'GetCB_OpenStream';
     220 : Result := 'GetCB_CloseStream';

     301 : Result := 'Set_Userdata';
     302 : Result := 'Set_CanvasStyle';
     303 : Result := 'Set_BkgdStyle';
     304 : Result := 'Set_BGcolor';
     305 : Result := 'Set_Storechunks';
     306 : Result := 'Set_Viewgamma';
     307 : Result := 'Set_Displaygamma';
     308 : Result := 'Set_Dfltimggamma';
     309 : Result := 'Set_sRGB';
     310 : Result := 'Set_OutputProfile';
     311 : Result := 'Set_sRGBProfile';
     312 : Result := 'Set_Maxcanvaswidth';
     313 : Result := 'Set_Maxcanvasheight';
     314 : Result := 'Set_Maxcanvassize';

     401 : Result := 'Get_Userdata';
     402 : Result := 'Get_Sigtype';
     403 : Result := 'Get_Imagetype';
     404 : Result := 'Get_Imagewidth';
     405 : Result := 'Get_Imageheight';
     406 : Result := 'Get_Ticks';
     407 : Result := 'Get_Framecount';
     408 : Result := 'Get_Layercount';
     409 : Result := 'Get_Playtime';
     410 : Result := 'Get_Simplicity';
     411 : Result := 'Get_CanvasStyle';
     412 : Result := 'Get_BkgdStyle';
     413 : Result := 'Get_BGcolor';
     414 : Result := 'Get_Storechunks';
     415 : Result := 'Get_Viewgamma';
     416 : Result := 'Get_Displaygamma';
     417 : Result := 'Get_Dfltimggamma';
     418 : Result := 'Get_sRGB';
     419 : Result := 'Get_Maxcanvaswidth';
     420 : Result := 'Get_Maxcanvasheight';

     601 : Result := 'IterateChunks';

     701 : Result := 'GetChunkIHDR';
     702 : Result := 'GetChunkPLTE';
     703 : Result := 'GetChunkIDAT';
     704 : Result := 'GetChunkIEND';
     705 : Result := 'GetChunkTRNS';
     706 : Result := 'GetChunkGAMA';
     707 : Result := 'GetChunkCHRM';
     708 : Result := 'GetChunkSRGB';
     709 : Result := 'GetChunkICCP';
     710 : Result := 'GetChunkTEXT';
     711 : Result := 'GetChunkZTXT';
     712 : Result := 'GetChunkITXT';
     713 : Result := 'GetChunkBKGD';
     714 : Result := 'GetChunkPHYS';
     715 : Result := 'GetChunkSBIT';
     716 : Result := 'GetChunkSPLT';
     717 : Result := 'GetChunkHIST';
     718 : Result := 'GetChunkTIME';
     719 : Result := 'GetChunkMHDR';
     720 : Result := 'GetChunkMEND';
     721 : Result := 'GetChunkLOOP';
     722 : Result := 'GetChunkENDL';
     723 : Result := 'GetChunkDEFI';
     724 : Result := 'GetChunkBASI';   
     725 : Result := 'GetChunkCLON';   
     726 : Result := 'GetChunkPAST';   
     727 : Result := 'GetChunkDISC';   
     728 : Result := 'GetChunkBACK';   
     729 : Result := 'GetChunkFRAM';
     730 : Result := 'GetChunkMOVE';
     731 : Result := 'GetChunkCLIP';
     732 : Result := 'GetChunkSHOW';
     733 : Result := 'GetChunkTERM';
     734 : Result := 'GetChunkSAVE';
     735 : Result := 'GetChunkSEEK';
     736 : Result := 'GetChunkEXPI';
     737 : Result := 'GetChunkFPRI';
     738 : Result := 'GetChunkNEED';
     739 : Result := 'GetChunkPHYG';
     740 : Result := 'GetChunkJHDR';
     741 : Result := 'GetChunkJDAT';
     742 : Result := 'GetChunkJSEP';
     743 : Result := 'GetChunkDHDR';
     744 : Result := 'GetChunkPROM';
     745 : Result := 'GetChunkIPNG';
     746 : Result := 'GetChunkPPLT';
     747 : Result := 'GetChunkIJNG';
     748 : Result := 'GetChunkDROP';
     749 : Result := 'GetChunkDBYK';
     750 : Result := 'GetChunkORDR';
     751 : Result := 'GetChunkUnknown';

     781 : Result := 'GetChunkPASTsource';
     782 : Result := 'GetChunkSAVEentry';
     783 : Result := 'GetChunkPPLTentry';
     784 : Result := 'GetChunkORDRentry';

     801 : Result := 'PutChunkIHDR';
     802 : Result := 'PutChunkPLTE';
     803 : Result := 'PutChunkIDAT';
     804 : Result := 'PutChunkIEND';
     805 : Result := 'PutChunkTRNS';
     806 : Result := 'PutChunkGAMA';
     807 : Result := 'PutChunkCHRM';
     808 : Result := 'PutChunkSRGB';
     809 : Result := 'PutChunkICCP';
     810 : Result := 'PutChunkTEXT';
     811 : Result := 'PutChunkZTXT';
     812 : Result := 'PutChunkITXT';
     813 : Result := 'PutChunkBKGD';
     814 : Result := 'PutChunkPHYS';
     815 : Result := 'PutChunkSBIT';
     816 : Result := 'PutChunkSPLT';
     817 : Result := 'PutChunkHIST';
     818 : Result := 'PutChunkTIME';
     819 : Result := 'PutChunkMHDR';
     820 : Result := 'PutChunkMEND';
     821 : Result := 'PutChunkLOOP';
     822 : Result := 'PutChunkENDL';
     823 : Result := 'PutChunkDEFI';
     824 : Result := 'PutChunkBASI';
     825 : Result := 'PutChunkCLON';
     826 : Result := 'PutChunkPAST';
     827 : Result := 'PutChunkDISC';
     828 : Result := 'PutChunkBACK';
     829 : Result := 'PutChunkFRAM';
     830 : Result := 'PutChunkMOVE';
     831 : Result := 'PutChunkCLIP';
     832 : Result := 'PutChunkSHOW';
     833 : Result := 'PutChunkTERM';
     834 : Result := 'PutChunkSAVE';
     835 : Result := 'PutChunkSEEK';
     836 : Result := 'PutChunkEXPI';
     837 : Result := 'PutChunkFPRI';
     838 : Result := 'PutChunkNEED';
     839 : Result := 'PutChunkPHYG';
     840 : Result := 'PutChunkJHDR';
     841 : Result := 'PutChunkJDAT';
     842 : Result := 'PutChunkJSEP';
     843 : Result := 'PutChunkDHDR';
     844 : Result := 'PutChunkPROM';
     845 : Result := 'PutChunkIPNG';
     846 : Result := 'PutChunkPPLT';
     847 : Result := 'PutChunkIJNG';
     848 : Result := 'PutChunkDROP';
     849 : Result := 'PutChunkDBYK';
     850 : Result := 'PutChunkORDR';
     851 : Result := 'PutChunkUnknown';

     881 : Result := 'PutChunkPASTsource';
     882 : Result := 'PutChunkSAVEentry';
     883 : Result := 'PutChunkPPLTentry';
     884 : Result := 'PutChunkORDRentry';

     901 : Result := 'GetImgDataSeq';
     902 : Result := 'GetImgDataChunkSeq';
     903 : Result := 'GetImgDataChunk';

     951 : Result := 'PutImgDataIHDR';
     952 : Result := 'PutImgDataJHDR';
     953 : Result := 'PutImgDataBASI';
     954 : Result := 'PutImgDataDHDR';

    1001 : Result := 'Process_Raw_Chunk';
    1002 : Result := 'Read_Graphic';
    1003 : Result := 'Drop_Chunks';
    1004 : Result := 'Process_Error';
    1005 : Result := 'Clear_CMS';
    1006 : Result := 'Drop_Objects';
    1007 : Result := 'Read_Chunk';
    1008 : Result := 'Load_BkgdLayer';
    1009 : Result := 'Next_Frame';
    1010 : Result := 'Next_Layer';
    1011 : Result := 'Interframe_delay';
    1012 : Result := 'Display_image';
    1013 : Result := 'Drop_ImgObjects';
    1014 : Result := 'Drop_AniObjects';
    1015 : Result := 'Inflate_Buffer';
    1016 : Result := 'Deflate_Buffer';
    1017 : Result := 'Write_Raw_Chunk';
    1018 : Result := 'Write_Graphic';
    1019 : Result := 'Save_State';
    1020 : Result := 'Restore_State';
    1021 : Result := 'Drop_SaveData';

    1101 : Result := 'Display_RGB8';
    1102 : Result := 'Display_RGBA8';
    1103 : Result := 'Display_ARGB8';
    1104 : Result := 'Display_BGR8';
    1105 : Result := 'Display_BGRA8';
    1106 : Result := 'Display_ABGR8';
    1107 : Result := 'Display_RGB16';
    1108 : Result := 'Display_RGBA16';
    1109 : Result := 'Display_ARGB16';
    1110 : Result := 'Display_BGR16';
    1111 : Result := 'Display_BGRA16';
    1112 : Result := 'Display_ABGR16';
    1113 : Result := 'Display_INDEX8';
    1114 : Result := 'Display_INDEXA8';
    1115 : Result := 'Display_AINDEX8';
    1116 : Result := 'Display_GRAY8';
    1117 : Result := 'Display_GRAY16';
    1118 : Result := 'Display_GRAYA8';
    1119 : Result := 'Display_GRAYA16';
    1120 : Result := 'Display_AGRAY8';
    1121 : Result := 'Display_AGRAY16';
    1122 : Result := 'Display_DX15';
    1123 : Result := 'Display_DX16';

    1201 : Result := 'Init_Full_CMS';
    1202 : Result := 'Correct_Full_CMS';
    1204 : Result := 'Init_Gamma_Only';
    1205 : Result := 'Correct_Gamma_Only';
    1206 : Result := 'Correct_APP_CMS';
    1207 : Result := 'Init_Full_CMS_Obj';
    1208 : Result := 'Init_Gamma_Only_Obj';
    1209 : Result := 'Init_APP_CMS';
    1210 : Result := 'Init_APP_CMS_Obj';

    1301 : Result := 'Process_G1';
    1302 : Result := 'Process_G2';
    1303 : Result := 'Process_G4';
    1304 : Result := 'Process_G8';
    1305 : Result := 'Process_G16';
    1306 : Result := 'Process_RGB8';
    1307 : Result := 'Process_RGB16';
    1308 : Result := 'Process_IDX1';
    1309 : Result := 'Process_IDX2';
    1310 : Result := 'Process_IDX4';
    1311 : Result := 'Process_IDX8';
    1312 : Result := 'Process_GA8';
    1313 : Result := 'Process_GA16';
    1314 : Result := 'Process_RGBA8';
    1315 : Result := 'Process_RGBA16';

    1401 : Result := 'Init_G1_NI';
    1402 : Result := 'Init_G1_I';
    1403 : Result := 'Init_G2_NI';
    1404 : Result := 'Init_G2_I';
    1405 : Result := 'Init_G4_NI';
    1406 : Result := 'Init_G4_I';
    1407 : Result := 'Init_G8_NI';
    1408 : Result := 'Init_G8_I';
    1409 : Result := 'Init_G16_NI';
    1410 : Result := 'Init_G16_I';
    1411 : Result := 'Init_RGB8_NI';
    1412 : Result := 'Init_RGB8_I';
    1413 : Result := 'Init_RGB16_NI';
    1414 : Result := 'Init_RGB16_I';
    1415 : Result := 'Init_IDX1_NI';
    1416 : Result := 'Init_IDX1_I';
    1417 : Result := 'Init_IDX2_NI';
    1418 : Result := 'Init_IDX2_I';
    1419 : Result := 'Init_IDX4_NI';
    1420 : Result := 'Init_IDX4_I';
    1421 : Result := 'Init_IDX8_NI';
    1422 : Result := 'Init_IDX8_I';
    1423 : Result := 'Init_GA8_NI';
    1424 : Result := 'Init_GA8_I';
    1425 : Result := 'Init_GA16_NI';
    1426 : Result := 'Init_GA16_I';
    1427 : Result := 'Init_RGBA8_NI';
    1428 : Result := 'Init_RGBA8_I';
    1429 : Result := 'Init_RGBA16_NI';
    1430 : Result := 'Init_RGBA16_I';

    1497 : Result := 'Init_RowProc';
    1498 : Result := 'Next_Row';
    1499 : Result := 'Cleanup_RowProc';

    1501 : Result := 'Filter_A_Row';
    1502 : Result := 'Filter_Sub';
    1503 : Result := 'Filter_Up';
    1504 : Result := 'Filter_Average';
    1505 : Result := 'Filter_Paeth';

    1601 : Result := 'Create_ImagedataObject';
    1602 : Result := 'Free_ImagedataObject';
    1603 : Result := 'Clone_ImagedataObject';
    1604 : Result := 'Create_ImageObject';
    1605 : Result := 'Free_ImageObject';
    1606 : Result := 'Find_ImageObject';
    1607 : Result := 'Clone_ImageObject';
    1608 : Result := 'Reset_Object_Details';
    1609 : Result := 'Renum_ImageObject';

    1701 : Result := 'Store_G1';
    1702 : Result := 'Store_G2';
    1703 : Result := 'Store_G4';
    1704 : Result := 'Store_G8';
    1705 : Result := 'Store_G16';
    1706 : Result := 'Store_RGB8';
    1707 : Result := 'Store_RGB16';
    1708 : Result := 'Store_IDX1';
    1709 : Result := 'Store_IDX2';
    1710 : Result := 'Store_IDX4';
    1711 : Result := 'Store_IDX8';
    1712 : Result := 'Store_GA8';
    1713 : Result := 'Store_GA16';
    1714 : Result := 'Store_RGBA8';
    1715 : Result := 'Store_RGBA16';

    1751 : Result := 'Retrieve_G8';
    1752 : Result := 'Retrieve_G16';
    1753 : Result := 'Retrieve_RGB8';
    1754 : Result := 'Retrieve_RGB16';
    1755 : Result := 'Retrieve_IDX8';
    1756 : Result := 'Retrieve_GA8';
    1757 : Result := 'Retrieve_GA16';
    1758 : Result := 'Retrieve_RGBA8';
    1759 : Result := 'Retrieve_RGBA16';

    1801 : Result := 'Create_Ani_LOOP';
    1802 : Result := 'Create_Ani_ENDL';
    1803 : Result := 'Create_Ani_DEFI';
    1804 : Result := 'Create_Ani_BASI';
    1805 : Result := 'Create_Ani_CLON';
    1806 : Result := 'Create_Ani_PAST';
    1807 : Result := 'Create_Ani_DISC';
    1808 : Result := 'Create_Ani_BACK';
    1809 : Result := 'Create_Ani_FRAM';
    1810 : Result := 'Create_Ani_MOVE';
    1811 : Result := 'Create_Ani_CLIP';
    1812 : Result := 'Create_Ani_SHOW';
    1813 : Result := 'Create_Ani_TERM';
    1814 : Result := 'Create_Ani_SAVE';
    1815 : Result := 'Create_Ani_SEEK';

    1891 : Result := 'Create_Ani_Image';

    1901 : Result := 'Free_Ani_LOOP';
    1902 : Result := 'Free_Ani_ENDL';
    1903 : Result := 'Free_Ani_DEFI';
    1904 : Result := 'Free_Ani_BASI';
    1905 : Result := 'Free_Ani_CLON';
    1906 : Result := 'Free_Ani_PAST';
    1907 : Result := 'Free_Ani_DISC';
    1908 : Result := 'Free_Ani_BACK';
    1909 : Result := 'Free_Ani_FRAM';
    1910 : Result := 'Free_Ani_MOVE';
    1911 : Result := 'Free_Ani_CLIP';
    1912 : Result := 'Free_Ani_SHOW';
    1913 : Result := 'Free_Ani_TERM';
    1914 : Result := 'Free_Ani_SAVE';
    1915 : Result := 'Free_Ani_SEEK';

    1991 : Result := 'Free_Ani_Image';

    2001 : Result := 'Process_Ani_LOOP';
    2002 : Result := 'Process_Ani_ENDL';
    2003 : Result := 'Process_Ani_DEFI';
    2004 : Result := 'Process_Ani_BASI';
    2005 : Result := 'Process_Ani_CLON';
    2006 : Result := 'Process_Ani_PAST';
    2007 : Result := 'Process_Ani_DISC';
    2008 : Result := 'Process_Ani_BACK';
    2009 : Result := 'Process_Ani_FRAM';
    2010 : Result := 'Process_Ani_MOVE';
    2011 : Result := 'Process_Ani_CLIP';
    2012 : Result := 'Process_Ani_SHOW';
    2013 : Result := 'Process_Ani_TERM';
    2014 : Result := 'Process_Ani_SAVE';
    2015 : Result := 'Process_Ani_SEEK';

    2091 : Result := 'Process_Ani_Image';

    2101 : Result := 'Restore_BACKimage';
    2102 : Result := 'Restore_BACKcolor';
    2103 : Result := 'Restore_BGcolor';
    2104 : Result := 'Restore_RGB8';
    2105 : Result := 'Restore_BGR8';

    2201 : Result := 'Init_IHDR';
    2202 : Result := 'Init_PLTE';
    2203 : Result := 'Init_IDAT';
    2204 : Result := 'Init_IEND';
    2205 : Result := 'Init_TRNS';
    2206 : Result := 'Init_GAMA';
    2207 : Result := 'Init_CHRM';
    2208 : Result := 'Init_SRGB';
    2209 : Result := 'Init_ICCP';
    2210 : Result := 'Init_TEXT';
    2211 : Result := 'Init_ZTXT';
    2212 : Result := 'Init_ITXT';
    2213 : Result := 'Init_BKGD';
    2214 : Result := 'Init_PHYS';
    2215 : Result := 'Init_SBIT';
    2216 : Result := 'Init_SPLT';
    2217 : Result := 'Init_HIST';
    2218 : Result := 'Init_TIME';
    2219 : Result := 'Init_MHDR';
    2220 : Result := 'Init_MEND';
    2221 : Result := 'Init_LOOP';
    2222 : Result := 'Init_ENDL';
    2223 : Result := 'Init_DEFI';
    2224 : Result := 'Init_BASI';           
    2225 : Result := 'Init_CLON';
    2226 : Result := 'Init_PAST';
    2227 : Result := 'Init_DISC';           
    2228 : Result := 'Init_BACK';           
    2229 : Result := 'Init_FRAM';           
    2230 : Result := 'Init_MOVE';           
    2231 : Result := 'Init_CLIP';           
    2232 : Result := 'Init_SHOW';
    2233 : Result := 'Init_TERM';           
    2234 : Result := 'Init_SAVE';           
    2235 : Result := 'Init_SEEK';           
    2236 : Result := 'Init_EXPI';
    2237 : Result := 'Init_FPRI';
    2238 : Result := 'Init_NEED';
    2239 : Result := 'Init_PHYG';
    2240 : Result := 'Init_JHDR';
    2241 : Result := 'Init_JDAT';
    2242 : Result := 'Init_JSEP';
    2243 : Result := 'Init_DHDR';
    2244 : Result := 'Init_PROM';
    2245 : Result := 'Init_IPNG';
    2246 : Result := 'Init_PPLT';
    2247 : Result := 'Init_IJNG';
    2248 : Result := 'Init_DROP';
    2249 : Result := 'Init_DBYK';
    2250 : Result := 'Init_ORDR';
    2251 : Result := 'Init_Unknown';

    2401 : Result := 'Free_IHDR';
    2402 : Result := 'Free_PLTE';
    2403 : Result := 'Free_IDAT';           
    2404 : Result := 'Free_IEND';           
    2405 : Result := 'Free_TRNS';           
    2406 : Result := 'Free_GAMA';           
    2407 : Result := 'Free_CHRM';           
    2408 : Result := 'Free_SRGB';           
    2409 : Result := 'Free_ICCP';
    2410 : Result := 'Free_TEXT';           
    2411 : Result := 'Free_ZTXT';
    2412 : Result := 'Free_ITXT';           
    2413 : Result := 'Free_BKGD';
    2414 : Result := 'Free_PHYS';           
    2415 : Result := 'Free_SBIT';           
    2416 : Result := 'Free_SPLT';           
    2417 : Result := 'Free_HIST';
    2418 : Result := 'Free_TIME';           
    2419 : Result := 'Free_MHDR';           
    2420 : Result := 'Free_MEND';           
    2421 : Result := 'Free_LOOP';           
    2422 : Result := 'Free_ENDL';           
    2423 : Result := 'Free_DEFI';           
    2424 : Result := 'Free_BASI';           
    2425 : Result := 'Free_CLON';           
    2426 : Result := 'Free_PAST';           
    2427 : Result := 'Free_DISC';           
    2428 : Result := 'Free_BACK';           
    2429 : Result := 'Free_FRAM';           
    2430 : Result := 'Free_MOVE';           
    2431 : Result := 'Free_CLIP';
    2432 : Result := 'Free_SHOW';
    2433 : Result := 'Free_TERM';
    2434 : Result := 'Free_SAVE';
    2435 : Result := 'Free_SEEK';
    2436 : Result := 'Free_EXPI';
    2437 : Result := 'Free_FPRI';
    2438 : Result := 'Free_NEED';
    2439 : Result := 'Free_PHYG';
    2440 : Result := 'Free_JHDR';
    2441 : Result := 'Free_JDAT';
    2442 : Result := 'Free_JSEP';
    2443 : Result := 'Free_DHDR';
    2444 : Result := 'Free_PROM';
    2445 : Result := 'Free_IPNG';
    2446 : Result := 'Free_PPLT';
    2447 : Result := 'Free_IJNG';
    2448 : Result := 'Free_DROP';
    2449 : Result := 'Free_DBYK';
    2450 : Result := 'Free_ORDR';
    2451 : Result := 'Free_Unknown';

    2601 : Result := 'Read_IHDR';
    2602 : Result := 'Read_PLTE';
    2603 : Result := 'Read_IDAT';           
    2604 : Result := 'Read_IEND';           
    2605 : Result := 'Read_TRNS';
    2606 : Result := 'Read_GAMA';           
    2607 : Result := 'Read_CHRM';           
    2608 : Result := 'Read_SRGB';           
    2609 : Result := 'Read_ICCP';           
    2610 : Result := 'Read_TEXT';           
    2611 : Result := 'Read_ZTXT';
    2612 : Result := 'Read_ITXT';           
    2613 : Result := 'Read_BKGD';           
    2614 : Result := 'Read_PHYS';           
    2615 : Result := 'Read_SBIT';           
    2616 : Result := 'Read_SPLT';           
    2617 : Result := 'Read_HIST';           
    2618 : Result := 'Read_TIME';           
    2619 : Result := 'Read_MHDR';
    2620 : Result := 'Read_MEND';           
    2621 : Result := 'Read_LOOP';           
    2622 : Result := 'Read_ENDL';           
    2623 : Result := 'Read_DEFI';           
    2624 : Result := 'Read_BASI';           
    2625 : Result := 'Read_CLON';
    2626 : Result := 'Read_PAST';           
    2627 : Result := 'Read_DISC';
    2628 : Result := 'Read_BACK';
    2629 : Result := 'Read_FRAM';           
    2630 : Result := 'Read_MOVE';           
    2631 : Result := 'Read_CLIP';
    2632 : Result := 'Read_SHOW';
    2633 : Result := 'Read_TERM';
    2634 : Result := 'Read_SAVE';
    2635 : Result := 'Read_SEEK';
    2636 : Result := 'Read_EXPI';
    2637 : Result := 'Read_FPRI';
    2638 : Result := 'Read_NEED';
    2639 : Result := 'Read_PHYG';
    2640 : Result := 'Read_JHDR';
    2641 : Result := 'Read_JDAT';
    2642 : Result := 'Read_JSEP';
    2643 : Result := 'Read_DHDR';
    2644 : Result := 'Read_PROM';
    2645 : Result := 'Read_IPNG';
    2646 : Result := 'Read_PPLT';
    2647 : Result := 'Read_IJNG';
    2648 : Result := 'Read_DROP';
    2649 : Result := 'Read_DBYK';
    2650 : Result := 'Read_ORDR';
    2651 : Result := 'Read_Unknown';

    2801 : Result := 'Write_IHDR';
    2802 : Result := 'Write_PLTE';
    2803 : Result := 'Write_IDAT';
    2804 : Result := 'Write_IEND';
    2805 : Result := 'Write_TRNS';
    2806 : Result := 'Write_GAMA';
    2807 : Result := 'Write_CHRM';
    2808 : Result := 'Write_SRGB';
    2809 : Result := 'Write_ICCP';
    2810 : Result := 'Write_TEXT';
    2811 : Result := 'Write_ZTXT';
    2812 : Result := 'Write_ITXT';
    2813 : Result := 'Write_BKGD';
    2814 : Result := 'Write_PHYS';
    2815 : Result := 'Write_SBIT';
    2816 : Result := 'Write_SPLT';
    2817 : Result := 'Write_HIST';
    2818 : Result := 'Write_TIME';
    2819 : Result := 'Write_MHDR';
    2820 : Result := 'Write_MEND';
    2821 : Result := 'Write_LOOP';
    2822 : Result := 'Write_ENDL';
    2823 : Result := 'Write_DEFI';
    2824 : Result := 'Write_BASI';
    2825 : Result := 'Write_CLON';
    2826 : Result := 'Write_PAST';
    2827 : Result := 'Write_DISC';
    2828 : Result := 'Write_BACK';
    2829 : Result := 'Write_FRAM';
    2830 : Result := 'Write_MOVE';
    2831 : Result := 'Write_CLIP';
    2832 : Result := 'Write_SHOW';
    2833 : Result := 'Write_TERM';
    2834 : Result := 'Write_SAVE';
    2835 : Result := 'Write_SEEK';
    2836 : Result := 'Write_EXPI';
    2837 : Result := 'Write_FPRI';
    2838 : Result := 'Write_NEED';
    2839 : Result := 'Write_PHYG';
    2840 : Result := 'Write_JHDR';
    2841 : Result := 'Write_JDAT';
    2842 : Result := 'Write_JSEP';
    2843 : Result := 'Write_DHDR';
    2844 : Result := 'Write_PROM';
    2845 : Result := 'Write_IPNG';
    2846 : Result := 'Write_PPLT';
    2847 : Result := 'Write_IJNG';
    2848 : Result := 'Write_DROP';
    2849 : Result := 'Write_DBYK';
    2850 : Result := 'Write_ORDR';
    2851 : Result := 'Write_Unknown';

    3001 : Result := 'ZLIB_Initialize';
    3002 : Result := 'ZLIB_Cleanup';
    3003 : Result := 'ZLIB_InflateInit';
    3004 : Result := 'ZLIB_Inflaterows';
    3005 : Result := 'ZLIB_Inflatedata';
    3006 : Result := 'ZLIB_InflateFree';
    3007 : Result := 'ZLIB_DeflateInit';
    3008 : Result := 'ZLIB_Deflaterows';
    3009 : Result := 'ZLIB_Deflatedata';
    3010 : Result := 'ZLIB_DeflateFree';

    3201 : Result := 'Process_Display_IHDR';
    3202 : Result := 'Process_Display_PLTE';
    3203 : Result := 'Process_Display_IDAT';
    3204 : Result := 'Process_Display_IEND';
    3205 : Result := 'Process_Display_TRNS';
    3206 : Result := 'Process_Display_GAMA';
    3207 : Result := 'Process_Display_CHRM';
    3208 : Result := 'Process_Display_SRGB';
    3209 : Result := 'Process_Display_ICCP';
    3210 : Result := 'Process_Display_BKGD';
    3211 : Result := 'Process_Display_PHYS';
    3212 : Result := 'Process_Display_SBIT';
    3213 : Result := 'Process_Display_SPLT';
    3214 : Result := 'Process_Display_HIST';
    3215 : Result := 'Process_Display_MHDR';
    3216 : Result := 'Process_Display_MEND';
    3217 : Result := 'Process_Display_LOOP';
    3218 : Result := 'Process_Display_ENDL';
    3219 : Result := 'Process_Display_DEFI';
    3220 : Result := 'Process_Display_BASI';
    3221 : Result := 'Process_Display_CLON';
    3222 : Result := 'Process_Display_PAST';
    3223 : Result := 'Process_Display_DISC';
    3224 : Result := 'Process_Display_BACK';
    3225 : Result := 'Process_Display_FRAM';
    3226 : Result := 'Process_Display_MOVE';
    3227 : Result := 'Process_Display_CLIP';
    3228 : Result := 'Process_Display_SHOW';
    3229 : Result := 'Process_Display_TERM';
    3230 : Result := 'Process_Display_SAVE';
    3231 : Result := 'Process_Display_SEEK';
    3232 : Result := 'Process_Display_EXPI';
    3233 : Result := 'Process_Display_FPRI';
    3234 : Result := 'Process_Display_NEED';
    3235 : Result := 'Process_Display_PHYG';
    3236 : Result := 'Process_Display_JHDR';
    3237 : Result := 'Process_Display_JDAT';
    3238 : Result := 'Process_Display_JSEP';
    3239 : Result := 'Process_Display_DHDR';
    3240 : Result := 'Process_Display_PROM';
    3241 : Result := 'Process_Display_IPNG';
    3242 : Result := 'Process_Display_PPLT';
    3243 : Result := 'Process_Display_IJNG';
    3244 : Result := 'Process_Display_DROP';
    3245 : Result := 'Process_Display_DBYK';
    3246 : Result := 'Process_Display_ORDR';

    3401 : Result := 'JPEG_Initialize';
    3402 : Result := 'JPEG_Cleanup';
    3403 : Result := 'JPEG_DecompressInit';
    3404 : Result := 'JPEG_DecompressData';
    3405 : Result := 'JPEG_DecompressFree';

    3501 : Result := 'Store_JPEG_G8';
    3502 : Result := 'Store_JPEG_RGB8';
    3503 : Result := 'Store_JPEG_G12';
    3504 : Result := 'Store_JPEG_RGB12';
    3505 : Result := 'Store_JPEG_GA8';
    3506 : Result := 'Store_JPEG_RGBA8';
    3507 : Result := 'Store_JPEG_GA12';
    3508 : Result := 'Store_JPEG_RGBA12';

    3511 : Result := 'Init_JPEG_A1_NI';
    3512 : Result := 'Init_JPEG_A2_NI';
    3513 : Result := 'Init_JPEG_A4_NI';
    3514 : Result := 'Init_JPEG_A8_NI';
    3515 : Result := 'Init_JPEG_A16_NI';

    3521 : Result := 'Store_JPEG_G8_A1';
    3522 : Result := 'Store_JPEG_G8_A2';
    3523 : Result := 'Store_JPEG_G8_A4';
    3524 : Result := 'Store_JPEG_G8_A8';
    3525 : Result := 'Store_JPEG_G8_A16';

    3531 : Result := 'Store_JPEG_RGB8_A1';
    3532 : Result := 'Store_JPEG_RGB8_A2';
    3533 : Result := 'Store_JPEG_RGB8_A4';
    3534 : Result := 'Store_JPEG_RGB8_A8';
    3535 : Result := 'Store_JPEG_RGB8_A16';

    3541 : Result := 'Store_JPEG_G12_A1';
    3542 : Result := 'Store_JPEG_G12_A2';
    3543 : Result := 'Store_JPEG_G12_A4';
    3544 : Result := 'Store_JPEG_G12_A8';
    3545 : Result := 'Store_JPEG_G12_A16';

    3551 : Result := 'Store_JPEG_RGB12_A1';
    3552 : Result := 'Store_JPEG_RGB12_A2';
    3553 : Result := 'Store_JPEG_RGB12_A4';
    3554 : Result := 'Store_JPEG_RGB12_A8';
    3555 : Result := 'Store_JPEG_RGB12_A16';

    3591 : Result := 'Next_JPEG_AlphaRow';
    3592 : Result := 'Next_JPEG_Row';

  else     Result := '?????';
  end;
end;

{****************************************************************************}

function mng_locationname (iLocation : mng_uint32) : string;
begin
  case iLocation of
       1 : Result := 'Start';
       2 : Result := 'End';
       3 : Result := 'Initialize';
       4 : Result := 'Cleanup';
  else     Result := '?????';
  end;
end;

{****************************************************************************}

end.
